{ config, pkgs, ... }: {
  imports = [
    ../hardware/fujitsu.nix
    # ../plugables/wireguard/mullvad.nix
    ../plugables/packages/base.nix
    ../plugables/packages/usability.nix
    ../modules/dns-records.nix
    ../plugables/avahi/default.nix
    ../plugables/znc/default.nix
    ../private/dns.nix
    #../sources/external/clever/qemu.nix
  ];

  # IMPORTANT: removing this causes avahi to fail
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [];
  
  nix.trustedUsers = [ "root" "remote-builder" ];

  users.extraUsers.remote-builder = {
    isNormalUser = true;
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [ vim syncthing-cli ];

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
          "/public" = {
            root = "/var/web/stuff/";
            extraConfig = "autoindex on;";
          };
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
      "rss.le0.gs" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };
  
  users.users.nginx.extraGroups = [ "keys" "syncthing" ];

  # TinyRSS rss service
  services.tt-rss = {
    enable = true;
    singleUserMode = true;
    database = {
      user = "tt_rss";
      password = "test";
    };
    pool = "tt-rss";
    virtualHost = "rss.le0.gs";
    selfUrlPath = "https://rss.le0.gs";
  };

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

  deployment.secrets = {
    "htpasswd" = {
      source = builtins.toString ../private/htpasswd;
      destination = "/run/keys/htpasswd";
      owner.user = "nginx";
      owner.group = "nginx";
      action = ["sudo" "systemctl" "reload" "nginx.service"];
    };
  };
}
