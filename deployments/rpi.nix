{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware/raspberry3.nix
    ../plugables/home-fleet.nix
    ../plugables/netdata.nix
    ../plugables/networking/server.nix
    ../plugables/packages/base.nix
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
}
