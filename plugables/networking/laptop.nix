{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Enable NetworkManager + iwd
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
  };

  # Enable Connman + iwd
  services.connman = {
    enable = false;
    wifi.backend = "iwd";
  };

  # Enable Avahi
  services.avahi = {
    enable = true;
    nssmdns = false;
    publish.enable = false;
  };
}
