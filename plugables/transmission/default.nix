{ config, pkgs, lib, ... }:
{
  # Enable Transmission torrent service
  services.transmission = { 
    enable = true;
    port = 9091;
    settings = {
      utp-enabled = true;
      dht-enabled = true;
      pex-enabled = true;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      peer-port = 10528;
      cache-size-mb = 32;
      peer-limit-global = 400;
      peer-limit-per-torrent = 100;
    };
  };
  systemd.services.transmission = {
    wantedBy = lib.mkForce [];
  };
}
