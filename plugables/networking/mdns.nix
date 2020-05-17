{ config, pkgs, lib, ... }:

{
  # Enable mDNS for systemd-resolved
  services.resolved.extraConfig = ''
    MulticastDNS=true
  '';

  # Enable mDNS for NetworkManager
  environment.etc."/NetworkManager/conf.d/mdns.conf".text = ''
    [connection]
    connection.mdns=2
  '';

  # Enable mDNS for systemd-networkd
  systemd.network.networks."40-physical" = {
    networkConfig = {
      MulticastDNS = "yes";
    };
  };

  # Open mDNS port
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
