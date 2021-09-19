{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Disable firewall per default
  networking.firewall.enable = false;

  # Setup all wired network interfaces
  systemd.network.networks."40-wired" = {
    matchConfig = { Name = lib.mkForce "enp* eth*"; };
    networkConfig = { DHCP = "yes"; };
    dhcpV4Config = { RouteMetric = 200; };
    dhcpV6Config = { RouteMetric = 200; };
  };

  # Protect all wireless networks from being unconfigured
  systemd.network.networks."40-wireless" = {
    matchConfig = { Name = lib.mkForce "wlp* wlan*"; };
    networkConfig = { DHCP = "yes"; };
    dhcpV4Config = { RouteMetric = 400; };
    dhcpV6Config = { RouteMetric = 400; };
  };

  # Wireless configuration with IWD
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false;
        UseDefaultInterface = false;
      };
      Network = {
        NameResolvingService = "systemd";
        RoutePriorityOffset = 300;
      };
    };
  };
}
