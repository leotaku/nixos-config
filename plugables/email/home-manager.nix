{ config, pkgs, lib, ... }:
let
  # Shortcuts
  notmuch-config = config.xdg.configHome + "/notmuch/notmuchrc";
  notmuch-cmd = pkgs.notmuch + "/bin/notmuch --config ${notmuch-config} ";

  # Path to postfix-style sasl password map
  pass_map_file = "/etc/nixos/nixos-config/private/postfix/sasl_password_maps";

  # Generate a working email config for a dir placed in ".maildir" and some other attributes
  myGenAccounts = dir:
    { name, address, imap, primary ? false, flavor ? "plain", syncBoxes }: rec {
      # Attributes directly read from record
      realName = name;
      userName = address;
      inherit address imap primary flavor;

      # Read password from postfix-style sasl password map
      passwordCommand = pkgs.gnugrep
        + "/bin/grep '${address}' ${pass_map_file} | ${pkgs.gnugrep}/bin/grep -o '[^:]*$' ";

      # Misc settings for home-manager email modules
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
        tls = { enable = false; };
      };

      msmtp = {
        enable = true;
        extraConfig = { auth = "off"; };
      };

      notmuch.enable = true;
    };
in {
  # Generate accounts from (hidden) attrsets
  accounts.email = {
    maildirBasePath = ".maildir";
    accounts = lib.mapAttrs myGenAccounts
      (import ../../private/mail-accounts.nix).accounts;
  };

  # Notmuch mail indexer
  programs.notmuch = {
    enable = true;
    extraConfig = { maildir = { synchronize_flags = "true"; }; };
    new = { tags = [ "unread" "new" ]; };
    hooks.postNew = ''
      # Accounts
      notmuch tag +outlook path:outlook/** tag:new
      notmuch tag +gmail   path:gmail/**   tag:new
      # Directory
      notmuch tag +inbox path:/Inbox/ tag:new
      notmuch tag +junk  path:/Junk/  tag:new
      # Notify
      NEW_MAIL="$(${notmuch-cmd} search tag:new)"
      if [ -n "$NEW_MAIL" ]; then
        ${pkgs.libnotify}/bin/notify-send "New Mail" "$NEW_MAIL"
      fi
      # Remove new tag
      notmuch tag -new tag:new
    '';
  };

  # Generate configs for all needed programs
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  home.file.".mbsyncrc".target = lib.mkForce ".config/mbsyncrc";

  # Enable mail services
  services.mbsync = {
    enable = true;
    configFile = config.home.file.".mbsyncrc".source;
    frequency = "*:0/5";
    postExec = notmuch-cmd + "new";
  };
}
