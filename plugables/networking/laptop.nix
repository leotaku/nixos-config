{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Disable firewall per default
  networking.firewall.enable = false;

  # Setup all wired network interfaces
  systemd.network.networks."40-wired" = {
    matchConfig = { Name = lib.mkForce "enp* eth*"; };
    networkConfig = { DHCP = "yes"; };
    dhcpV4Config = {
      RouteMetric = 200;
      UseDNS = false;
    };
    dhcpV6Config = {
      RouteMetric = 200;
      UseDNS = false;
    };
  };

  # Protect all wireless networks from being unconfigured
  systemd.network.networks."40-wireless" = {
    matchConfig = { Name = lib.mkForce "wlp* wlan*"; };
    networkConfig = { DHCP = "yes"; };
    dhcpV4Config = {
      RouteMetric = 400;
      UseDNS = false;
    };
    dhcpV6Config = {
      RouteMetric = 400;
      UseDNS = false;
    };
  };

  # Wireless configuration with IWD
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false;
        UseDefaultInterface = true;
      };
      Network = {
        NameResolvingService = "systemd";
        RoutePriorityOffset = 300;
      };
    };
  };

  # Reset IWD on waking up from suspend
  powerManagement.powerDownCommands = "${pkgs.systemd}/bin/systemctl stop iwd.service";
  powerManagement.powerUpCommands = "${pkgs.systemd}/bin/systemctl start iwd.service";
}
