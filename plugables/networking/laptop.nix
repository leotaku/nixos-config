{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
    insertNameservers = config.networking.nameservers;
  };
  networking.useDHCP = false;

  # Wireless
  networking.wireless.iwd.enable = true;
  environment.etc."iwd/main.conf".text = ''
    [General]
    UseDefaultInterface=true
  '';

  # Enable Avahi
  services.avahi = {
    enable = true;
    nssmdns = false;
    publish.enable = false;
  };
}
