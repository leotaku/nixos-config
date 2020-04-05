# TODO: Maybe also/only report errors from imapnotify?
{ config, pkgs, lib, ... }:
let
  # Command shortcuts
  notify = title: body: ''${pkgs.libnotify}/bin/notify-send "${title}" "${body}"'';
  notmuch-new-command = "${pkgs.notmuch}/bin/notmuch --config=${config.xdg.configHome}/notmuch/notmuchrc new";
  # Path to postfix-style sasl password map
  pass_map_file = "/etc/nixos/nixos-config/private/postfix/sasl_password_maps";

  # Generate a working email config for a dir placed in ".maildir" and some other attributes
  myGenAccounts = dir: { name, pre, post, imap, primary ? false, flavor ? "plain", syncBoxes ? [ ] }:
  rec {
    # Attributes directly read from record
    realName = name;
    userName = address;
    address = "${pre}@${post}";
    inherit imap primary flavor;

    # Read password from postfix-style sasl password map
    passwordCommand = ''${pkgs.gnugrep}/bin/grep '${address}' ${pass_map_file} | ${pkgs.gnugrep}/bin/grep -o '[^:]*$' '';

    # Misc settings for home-manager email modules

    imapnotify = {
      enable = true;
      boxes = syncBoxes;
      onNotify = pkgs.systemd + "/bin/systemctl --user start mbsync.service";
      onNotifyPost = {
        mail = notmuch-new-command + "&&" + (notify "You got mail!" userName);
      };
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "none";
      flatten = ".";
      patterns = [ "*" "!.*" "!Sent" "!Drafts" ];
    };

    smtp = {
      host = "localhost";
      port = 25;
      tls = {
        enable = false;
      };
    };

    msmtp = {
      enable = true;
      extraConfig = { auth = "off"; };
    };

    notmuch.enable = true;

  };
in
{
  # Generate accounts from (hidden) attrsets
  accounts.email = {
    maildirBasePath = ".maildir";
    accounts = lib.mapAttrs myGenAccounts (import ../../private/mail-accounts.nix).accounts;
  };

  # Notmuch mail indexer
  programs.notmuch = {
    enable = true;
    extraConfig = {
      maildir = {
        synchronize_flags = "true";
      };
    };
    new = {
      tags = [ "unread" "new" ];
    };
    hooks.postNew = ''
      # Accounts
      notmuch tag +outlook path:outlook/** tag:new
      notmuch tag +gmail   path:gmail/**   tag:new
      # Directory
      notmuch tag +inbox path:/Inbox/ tag:new
      notmuch tag +junk  path:/Junk/  tag:new
      # Remove new tag
      notmuch tag -new tag:new
    '';
  };

  # Generate configs for all needed programs
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.alot.enable = false;

  home.file.".mbsyncrc".target = lib.mkForce ".config/mbsyncrc";

  services.mbsync = {
    enable = true;
    configFile = config.home.file.".mbsyncrc".source;
    frequency = "*:0/15";
    postExec = notmuch-new-command;
  };
  services.imapnotify.enable = true;
  systemd.user.services.mbsync.Unit.OnFailure = "mbsync-error.service";

  systemd.user.services."mbsync-error" = {
    Service = {
      ExecStart = notify "Mail sync error" "Please check your mbsync configuration!";
    };
  };

  # Mailcap handling
  home.file.".mailcap".text = ''
    # This is a simple example mailcap file.
    # Lines starting with '#' are comments.

    text/html; ${pkgs.w3m}/bin/w3m -dump -o document_charset=%{charset} '%s'; nametemplate=%s.html; copiousoutput
  '';
}
