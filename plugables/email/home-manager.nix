{ config, pkgs, lib, ... }:
let
  # path to postfix-style sasl password map
  pass_map_file = "/etc/nixos/nixos-config/private/postfix/sasl_password_maps";
  # generate a working email config for a dir placed in ".maildir" and some other attributes
  myGenAccounts = dir: { name, pre, post, imap, primary ? false, flavor ? "plain", syncBoxes ? [ ] }:
  rec {
    # Attributes directly read from record
    realName = name;
    userName = address;
    address = "${pre}@${post}";
    inherit imap primary flavor;

    # read password from postfix-style sasl password map
    passwordCommand = ''${pkgs.gnugrep}/bin/grep '${address}' ${pass_map_file} | ${pkgs.gnugrep}/bin/grep -o '[^:]*$' '';

    # misc settings for home-manager email modules
    
    imapnotify = {
      enable = true;
      boxes = syncBoxes;
      onNotify = "${pkgs.isync}/bin/mbsync ${dir}";
      onNotifyPost = {
        mail = ''
          ${pkgs.notmuch}/bin/notmuch --config=${config.xdg.configHome}/notmuch/notmuchrc new &&\
          ${pkgs.libnotify}/bin/notify-send "You got mail!" "${userName}"
        '';
      };
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "none";
      flatten = ".";
      patterns = [ "*" "!.*" ];
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

  # notmuch mail indexer
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

  services.mbsync =  {
    enable = true;
    frequency = "*:0/15";
    postExec = "${pkgs.notmuch}/bin/notmuch --config=${config.xdg.configHome}/notmuch/notmuchrc new";
  };
  services.imapnotify.enable = true;
}
