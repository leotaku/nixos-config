{ config, pkgs, lib, ... }:
{
  # Enable Transmission torrent service
  services.transmission = { 
    enable = true;
    port = 9091;
    settings = {
      utp-enabled = true;
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      peer-port = 10528;
    };
  };
  systemd.services.transmission = {
    wantedBy = lib.mkForce [];
  };
}
