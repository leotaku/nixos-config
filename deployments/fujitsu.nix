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

  # Emulate WebAssembly and ARM
  boot.binfmt.emulatedSystems = [ "wasm32-wasi" "aarch64-linux" ];

  # Hostname
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [ (import ../pkgs) ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    ethtool
    freeipmi
    goatcounter
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
  services.openssh.enable = true;

  # Enable Fail2Ban firewall
  services.fail2ban = {
    enable = true;
    packageFirewall = config.networking.firewall.package;
  };

  # Hercules-CI agent
  services.hercules-ci-agent = {
    enable = true;
    settings = {
      concurrentTasks = 12;
    };
  };

  # Miniflux RSS
  services.miniflux = {
    enable = true;
    config = { LISTEN_ADDR = "0.0.0.0:1270"; };
  };

  # Backup and syncing
  services.restic.server = {
    enable = true;
    prometheus = true;
    dataDir = config.fileSystems.raid1x5tb.mountPoint + "/restic";
    extraFlags = [ "--no-auth" ];
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
  virtualisation.docker.enable = false;
  programs.wireshark.enable = false;

  # Udisks depends on GTK+ which I don't want on my headless servers
  services.udisks2.enable = false;

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 22 80 443 8000 8384 6667 6697 25565 ];
}
