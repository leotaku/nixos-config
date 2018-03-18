{ config, pkgs, lib, ... }:
{
  # Enable Transmission torrent service, with proxy
  services.transmission-proxy = { 
    enable = true;
    port = 9091;
    proxy = {
      ip = "10.8.0.1";
      port = "1080";
      type = "socks5";
    };
    settings = {
      utp-enabled = true;
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      peer-port = 10528;
    };
  };
}
