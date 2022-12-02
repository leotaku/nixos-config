{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware/raspberry3.nix
    ../plugables/mesh.nix
    ../plugables/netdata.nix
    ../plugables/networking/server.nix
  ];

  # Hostname
  networking.hostName = "nixos-rpi";

  # Nixpkgs configurations
  nixpkgs = rec {
    # Tell the host system that it should build for AArch64
    crossSystem = lib.systems.elaborate {
      config = "aarch64-unknown-linux-gnu";
    };
    localSystem = crossSystem;
    overlays = [ (import ../pkgs) ];
  };

  environment.systemPackages = with pkgs; [ emv htop kakoune ncdu tmux ];

  # Netdata monitoring
  services.nginx = {
    enable = true;
    package = pkgs.nginxMainline;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "localhost" = {
        locations = {
          "/".proxyPass = "http://localhost:19999/";
        };
      };
    };
  };

  # Udisks depends on GTK+ which I don't want on my headless servers
  services.udisks2.enable = false;

  # Enable SSH
  services.openssh.enable = true;

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "23.05"; # Did you read the comment?
}
