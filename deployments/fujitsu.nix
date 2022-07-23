{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware/fujitsu.nix
    ../plugables/mesh.nix
    ../plugables/netdata.nix
    ../plugables/networking/server.nix
    ../plugables/torrenting.nix
    ../plugables/webserver.nix
    ../plugables/znc.nix
  ];

  # Emulate WebAssembly and ARM
  boot.binfmt.emulatedSystems = [ "wasm32-wasi" "aarch64-linux" ];

  # Hostname
  networking.hostName = "nixos-fujitsu";

  # Nixpkgs configurations
  nixpkgs.overlays = [ (import ../pkgs) ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    emv
    ethtool
    freeipmi
    goatcounter
    htop
    ipmitool
    kakoune
    ncdu
    restic
    syncthing-cli
    tmux
  ];

  # Setup correct keyboard
  console.keyMap = "de";

  # Enable SSH
  services.openssh.enable = true;

  # Enable libvirtd
  virtualisation.libvirtd.enable = true;
  security.polkit.enable = true;

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

  # Backup and syncing
  services.restic.server = {
    enable = true;
    prometheus = true;
    dataDir = config.fileSystems.raid1x5tb.mountPoint + "/restic";
    extraFlags = [
      "--no-auth" "--tls"
      "--tls-cert=/var/lib/acme/le0.gs/cert.pem"
      "--tls-key=/var/lib/acme/le0.gs/key.pem"
    ];
  };
  users.users."restic".extraGroups = [ "acme" ];

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
    package = let
      server = pkgs.fetchurl {
        url =
          "https://papermc.io/api/v2/projects/paper/versions/1.18.2/builds/252/downloads/paper-1.18.2-252.jar";
        sha256 = "0gwz2j03a3yp87d12v7yr9954169dcsn7cf5ayvcnhp8xlsyzavi";
      };
    in pkgs.writeShellScriptBin "minecraft-server" ''
      ${pkgs.jre}/bin/java -Xmx3G -Xms2G -jar ${server} nogui
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
