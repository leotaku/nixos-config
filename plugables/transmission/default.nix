{ config, pkgs, lib, ... }:
{
  # Enable Transmission torrent service
  services.transmission = { 
    enable = true;
    port = 9091;
    settings = {
      utp-enabled = false;
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      peer-port = 10528;
      #proxy-enabled = true;
      #proxy = "10.8.0.1";
      #proxy-port = 1080;
      #proxy-type = 2;
    };
  };
  
  # Disable autostart
  systemd.services.transmission = {
    wantedBy = lib.mkOverride 50 [];
    #environment.systemPackages = lib.mkOverride 50 [];
  };
}
