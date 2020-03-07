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
      port-forwarding-enabled = true;
      # Forwarded port (set in mullvad web conf)
      peer-port = 13525;
      cache-size-mb = 32;
      peer-limit-global = 400;
      peer-limit-per-torrent = 100;
    };
  };
  systemd.services.transmission = {
    wantedBy = lib.mkForce [];
  };
}
