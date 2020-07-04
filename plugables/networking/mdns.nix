{ config, pkgs, lib, ... }:

{
  # Enable LLMNR for systemd-resolved
  services.resolved.llmnr = "true";
  services.resolved.extraConfig = ''
    MulticastDNS=false
  '';

  # Enable Zeroconf awareness for NetworkManager
  environment.etc."/NetworkManager/conf.d/mdns.conf".text = ''
    [connection]
    connection.mdns=2
    connection.llmnr=2
  '';

  # Enable Zeroconf awareness for systemd-networkd
  systemd.network.networks."40-physical" = {
    networkConfig = {
      MulticastDNS = "yes";
      LLMNR = "yes";
    };
  };

  # Open Zeroconf ports
  networking.firewall.allowedUDPPorts = [ 5353 5355 ];
}
