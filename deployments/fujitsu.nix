{ config, pkgs, lib, ... }: {
  imports = with (import ../sources/nix/sources.nix); [
    ../hardware/fujitsu.nix
    ../plugables/builders.nix
    ../plugables/packages/base.nix
    ../plugables/packages/usability.nix
    ../plugables/avahi.nix
    ../plugables/znc.nix
    (hercules-ci-agent + "/module.nix")
  ];

  # IMPORTANT: removing this causes avahi to fail
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [ (import ../pkgs) ];

  nix.trustedUsers = [ "root" ];

  environment.systemPackages = with pkgs; [
    syncthing-cli
    restic
    ipmitool
    freeipmi
    dnsmasq
    ethtool
  ];

  # Setup correct keyboard
  i18n.consoleKeyMap = "de";

  # Networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;
  networking.interfaces."enp8s0".useDHCP = true;
  networking.interfaces."enp7s0".useDHCP = true;
  networking.interfaces."enp6s0".useDHCP = true;

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

    # Always use UTF-8
    appendHttpConfig = "charset utf-8;";

    virtualHosts = {
      "le0.gs" = {
        useACMEHost = "le0.gs";
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
        basicAuthFile = config.deployment.secrets."htpasswd".destination;
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
      webroot = config.services.nginx.virtualHosts."le0.gs".acmeRoot;
      extraDomains = {
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
    dataDir = config.fileSystems.raid1x5tb.mountPoint + "/restic";
  };
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
    group = "syncthing";
  };

  # Minecraft server
  services.minecraft-server = rec {
    enable = true;
    eula = true;
    package = pkgs.writeShellScriptBin "minecraft-server" ''
      ${pkgs.jre}/bin/java -Xmx3G -Xms2G -jar ${dataDir}/server.jar nogui
    '';
    dataDir = "/var/lib/minecraft";
    declarative = true;
    serverProperties = {
      motd = "Yolomaudadolo!!!";
      allow-flight = true;
      enable-command-block = true;
    };
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
  services.fail2ban.enable = true;

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
    # Minecraft server
    25565
  ];

  deployment.secrets = {
    "htpasswd" = {
      source = builtins.toString ../private/htpasswd;
      destination = "/var/keys/htpasswd";
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
