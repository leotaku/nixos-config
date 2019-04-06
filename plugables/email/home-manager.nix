{ config, lib, pkgs, ... }:

let
  # This has to match "smtp_sasl_password_maps" in ./postfix-queue.nix
  pass_map_file = "/etc/nixos/nixos-config/private/postfix/sasl_password_maps";
  createAccount = {fakePrimary, realName, userName, address, imap }:
  {
    inherit realName userName address;
    passwordCommand = ''${pkgs.gnugrep}/bin/grep "${address}" ${pass_map_file} | ${pkgs.gnugrep}/bin/grep -o "[^:]*$" ${pass_map_file}'';
    flavor = "plain";
    primary = fakePrimary;

    inherit imap;

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
      flatten = ".";
      patterns = [ "*" "!.*" ];
    };
    
    msmtp = {
      enable = false;
    };

    notmuch.enable = true;
    
  };

  createMsmtprc = symbol: value: 
  ''
account ${symbol}
auth off
from ${value.address}
host localhost
port 25
tls off
tls_starttls off
user ${value.userName}
  '';
in

rec {
  accounts.email = {
    maildirBasePath = ".maildir";
    accounts = {
      outlook = createAccount (import ./../../private/mail/accounts.nix).outlook;
    };
  };

  home.file.".msmtprc".text = lib.concatStringsSep "\n\n"
    ((lib.mapAttrsToList createMsmtprc accounts.email.accounts) ++ ["account default : outlook"]);

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  
  services.mbsync =  {
    enable = true;
    postExec = ''
      ${pkgs.dash}/bin/dash -c '\
      ${pkgs.notmuch}/bin/notmuch --config=${config.xdg.configHome}/notmuch/notmuchrc new'
    '';
      #${pkgs.mu}/bin/mu index --maildir=${accounts.email.maildirBasePath}'
  };

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
    # TODO: make initial tagging more general
    hooks.postNew = ''
    notmuch tag +inbox folder:outlook/Inbox tag:new
    notmuch tag -new tag:new
    '';
  };

  home.file.".mailcap".text = ''
      text/html; ${pkgs.w3m}/bin/w3m -dump %s; nametemplate=%s.html; copiousoutput
    '';

}
