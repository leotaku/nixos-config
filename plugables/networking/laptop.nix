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
  };

  # Wireless
  networking.wireless.iwd.enable = true;
  environment.etc."iwd/main.conf".text = ''
    [General]
    EnableNetworkConfiguration=true
    UseDefaultInterface=true
    [Network]
    NameResolvingService=systemd
    RoutePriorityOffset=2048
  '';

  # Enable Avahi
  services.avahi = {
    enable = true;
    nssmdns = false;
    publish.enable = false;
  };
}
