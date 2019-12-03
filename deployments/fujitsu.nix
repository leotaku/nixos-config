{ config, pkgs, ... }: {
  imports = with (import ../sources/nix/sources.nix); [
    ../hardware/fujitsu.nix
    ../plugables/builders/module.nix
    ../plugables/packages/base.nix
    ../plugables/packages/usability.nix
    ../plugables/avahi/module.nix
    ../plugables/znc/module.nix
    ../modules/dns-safe.nix
    (hercules-ci-agent + "/module.nix")
  ];

  # IMPORTANT: removing this causes avahi to fail
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [ ];
  
  nix.trustedUsers = [ "root" "remote-builder" ];

  environment.systemPackages = with pkgs; [ vim syncthing-cli ];

  # Update DNS records
  services.dns-records-update = {
    enable = true;
    urlsFile = "/run/dnsfile";
  };

  # Hercules-CI agent
  services.hercules-ci-agent.enable = true;
  services.hercules-ci-agent.concurrentTasks = 4;

  # Nginx server
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
        forceSSL = true;
        locations = {
          "/".root = pkgs.callPackage ./site/default.nix { };
          "/public" = {
            root = "/var/web/stuff/";
            extraConfig = "autoindex on;";
          };
        };
      };
      "sync.le0.gs" = {
        useACMEHost = "le0.gs";
        forceSSL = true;
        basicAuthFile = "/run/htpasswd";
        locations = {
          "/" = {
            root = "/var/web/stuff";
            extraConfig = "autoindex on;";
          };
          "/restic".root = "/var/web";
        };
      };
      "stats.le0.gs" = {
        useACMEHost = "le0.gs";
        forceSSL = true;
        locations = {
          "/".return = "301 /fujitsu/";
          "/fujitsu".proxyPass = "http://localhost:19999/";
          "/rpi".proxyPass = "http://nixos-rpi.local/";
        };
      };
      "rss.le0.gs" = {
        useACMEHost = "le0.gs";
        forceSSL = true;
      };
    };
  };

  # NOTE: the keys group is used only for NixOps compatibility
  users.users.nginx.extraGroups = [ "keys" "syncthing" ];

  # Acme certificates
  security.acme.certs = {
    "le0.gs" = {
      email = "leo.gaskin@brg-feldkirchen.at";
      extraDomains = {
        "vwa.le0.gs" = null;
        "sync.le0.gs" = null;
        "stats.le0.gs" = null;
        "rss.le0.gs" = null;
      };
    };
  };

  # TinyRSS rss service
  services.tt-rss = {
    enable = true;
    # NOTE: Maybe switch to http-auth?
    singleUserMode = false;
    auth.autoCreate = false;
    registration.enable = false;
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
    # SSH
    22
    # HTTP(S)
    80
    443
    # Restic
    8000
    # Syncthing
    8384
    # ZNC
    6667
  ];

  deployment.secrets = {
    "dnsfile" = {
      source = builtins.toString ../private/dnsfile;
      destination = "/run/dnsfile";
      action = ["systemctl" "restart" "dns-records-update.service"];
    };
    "htpasswd" = {
      source = builtins.toString ../private/htpasswd;
      destination = "/run/htpasswd";
      owner.user = "nginx";
      owner.group = "nginx";
      action = ["systemctl" "reload" "nginx.service"];
    };
    "binary-caches.json" = {
      source = builtins.toString ../private/binary-caches.json;
      destination = "/var/lib/hercules-ci-agent/secrets/binary-caches.json";
      owner.user = "hercules-ci-agent";
      owner.group = "nogroup";
      action = ["systemctl" "restart" "hercules-ci-agent.service"];
    };
    "cluster-join-token.key" = {
      source = builtins.toString ../private/cluster-join-token.key;
      destination = "/var/lib/hercules-ci-agent/secrets/cluster-join-token.key";
      owner.user = "hercules-ci-agent";
      owner.group = "nogroup";
      action = ["systemctl" "restart" "hercules-ci-agent.service"];
    };
  };
}
