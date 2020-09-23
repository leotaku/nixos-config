{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware/fujitsu.nix
    ../plugables/home-fleet.nix
    ../plugables/netdata.nix
    ../plugables/networking/server.nix
    ../plugables/packages/base.nix
    ../plugables/packages/usability.nix
    ../plugables/torrenting.nix
    ../plugables/webserver.nix
    ../plugables/znc.nix
  ];

  # Enable unstable features
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };

  # Hostname
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [ (import ../pkgs) ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    ethtool
    freeipmi
    ipmitool
    restic
    syncthing-cli
  ];

  # Global environment
  environment.variables = with pkgs; {
    EDITOR = kakoune + "/bin/kak";
  };

  # Setup correct keyboard
  console.keyMap = "de";

  # Enable SSH
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  # Enable Fail2ban firewall
  services.fail2ban = {
    enable = true;
    packageFirewall = config.networking.firewall.package;
  };

  # Hercules-CI agent
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = 8;
    patchNix = false;
  };

  # TinyRSS rss service
  services.tt-rss = {
    enable = true;
    # TODO: Switch to http-auth only
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

  # Enable simple programs and services
  services.haveged.enable = true;
  services.jellyfin.enable = true;
  programs.wireshark.enable = true;

  # Udisks depends on GTK+ which I don't want on my headless servers
  services.udisks2.enable = false;

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 22 80 443 8000 8384 6667 25565 ];

  deployment.secrets = {
    "cloudflare.env" = {
      source = builtins.toString ../private/cloudflare.env;
      destination = "/var/keys/cloudflare.env";
      owner.user = "root";
      owner.group = "root";
      action = [ "systemctl" "restart" "cloudflare-dns.service" ];
    };
    "htpasswd" = {
      source = builtins.toString ../private/htpasswd;
      destination = "/var/keys/htpasswd";
      owner.user = "nginx";
      owner.group = "nginx";
      action = [ "systemctl" "reload" "nginx.service" ];
    };
    "binary-caches.json" = {
      source = builtins.toString ../private/binary-caches.json;
      destination = "/var/lib/hercules-ci-agent/secrets/binary-caches.json";
      owner.user = "hercules-ci-agent";
      owner.group = "nogroup";
      action = [ "systemctl" "restart" "hercules-ci-agent.service" ];
    };
    "cluster-join-token.key" = {
      source = builtins.toString ../private/cluster-join-token.key;
      destination = "/var/lib/hercules-ci-agent/secrets/cluster-join-token.key";
      owner.user = "hercules-ci-agent";
      owner.group = "nogroup";
      action = [ "systemctl" "restart" "hercules-ci-agent.service" ];
    };
  };
}
