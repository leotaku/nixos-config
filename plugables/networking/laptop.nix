{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Disable firewall per default
  networking.firewall.enable = false;

  # Use systemd-networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;

  # Setup all wired network interfaces
  systemd.network.networks."40-wired" = {
    matchConfig = { Name = lib.mkForce "enp* eth*"; };
    networkConfig = {
      DHCP = "yes";
    };
    dhcpV4Config = {
      RouteMetric = 200;
    };
    dhcpV6Config = {
      RouteMetric = 200;
    };
  };

  # Protect all wireless networks from being unconfigured
  systemd.network.networks."40-wireless" = {
    matchConfig = { Name = lib.mkForce "wlp* wlan*"; };
    networkConfig = {
      DHCP = "yes";
    };
    dhcpV4Config = {
      RouteMetric = 400;
    };
    dhcpV6Config = {
      RouteMetric = 400;
    };
  };

  # Wireless configuration with IWD
  networking.wireless.iwd.enable = true;
  environment.etc."iwd/main.conf".text = ''
    [General]
    EnableNetworkConfiguration=false
    UseDefaultInterface=true
    [Network]
    NameResolvingService=systemd
    RoutePriorityOffset=300
  '';

  # Enable Avahi
  services.avahi = {
    enable = true;
    nssmdns = false;
    publish.enable = false;
  };
}
