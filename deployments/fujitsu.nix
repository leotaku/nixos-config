{
  network.description = "Fujitsu Server";
  network.enableRollback = true;

  nixos-fujitsu = { config, pkgs, ... }: {
    imports = [
      ../hardware/fujitsu.nix
      # ../plugables/wireguard/mullvad.nix
      ../plugables/packages/base.nix
      ../plugables/packages/usability.nix
      ../modules/dns-records.nix
      ../plugables/avahi/default.nix
      ../plugables/znc/default.nix
      ../private/dns.nix
      ../sources/external/clever/qemu.nix
    ];

    qemu-user.aarch64 = true;

    nix.trustedUsers = [ "root" "remote-builder" ];

    users.extraUsers.remote-builder = {
      isNormalUser = true;
      shell = pkgs.bash;
    };

    environment.systemPackages = with pkgs; [
      vim
      syncthing-cli
    ];

    services.nginx = {
      enable = true;
      package = pkgs.nginxMainline;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts = {
        "le0.gs" = {
          enableACME = true;
          #useACMEHost = "le0.gs";
          #addSSL = true;
          forceSSL = true;
          locations = {
            "/".root = "${pkgs.callPackage ./site/default.nix { }}/";
          };
        };
        "vwa.le0.gs" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/".root = "/var/web/hugo/public";
            "/rustdoc" = {
              root = "/var/web/";
              index = "settings.html";
            };
          };
        };
        "sync.le0.gs" = {
          enableACME = true;
          forceSSL = true;
          basicAuthFile = "/run/keys/htpasswd";
          locations = {
            "/" = {
              root = "/var/web/stuff";
              extraConfig = "autoindex on;";
            };
            "/restic".root = "/var/web";
          };
        };
        "stats.le0.gs" = {
          enableACME = true;
          forceSSL = true;
          locations = { "/".proxyPass = "http://localhost:19999/"; };
        };
      };
    };
    users.users.nginx.extraGroups = [ "keys" "syncthing" ];

    # security.acme.certs = {
    #   "le0.gs" = { 
    #     email = "leo.gaskin@brg-feldkirchen.at";
    #     webroot = "/var/lib/acme/acme-challenges";
    #     extraDomains = {
    #       "le0.gs" = null;
    #       "test.le0.gs" = null;
    #     };
    #     postRun = "systemctl restart nginx.service";
    #   };
    # };

    # Backup and syncing
    services.restic.server = {
      enable = true;
      prometheus = true;
    };
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true;
      group = "syncthing";
    };

    # enable netdata monitoring
    services.netdata.enable = true;

    # enable haveged service for more entropy
    services.haveged.enable = true;
    
    # Udisks depends on gtk+ which I don't want on my headless servers
    services.udisks2.enable = false;

    # enable SSH
    services.openssh.enable = true;
    services.openssh.permitRootLogin = "yes";

    # Avahi
    services.avahi.enable = true;

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [
      # ssh
      22
      # http(s)
      80
      443
      # restic
      8000
      # syncthing
      8384
      # stuff
      6667
      666
    ];

    deployment.targetHost = "nixos-fujitsu.local";
    # deployment.targetHost = "192.168.178.40";
    
    deployment.keys = {
      "htpasswd" = {
        keyFile = ../private/htpasswd;
        user = "nginx";
        group = "nginx";
      };
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = false;
  };
}
