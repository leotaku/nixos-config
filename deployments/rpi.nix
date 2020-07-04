{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware/raspberry3.nix
    ../plugables/builders.nix
    ../plugables/networking/server.nix
    ../plugables/packages/base.nix
  ];

  # Hostname
  networking.hostName = "nixos-rpi";

  # Nixpkgs configurations
  nixpkgs = rec {
    # Tell the host system that it should build for aarch64
    crossSystem = lib.systems.elaborate {
      config = "aarch64-unknown-linux-gnu";
    };
    localSystem = crossSystem;
    overlays = [];
  };

  environment.systemPackages = with pkgs; [ hello ];

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

  # Enable simple services
  services.netdata.enable = true;

  # Udisks depends on gtk+ which I don't want on my headless servers
  services.udisks2.enable = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
}
