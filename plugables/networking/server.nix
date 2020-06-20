{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Use systemd-networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;

  # Setup all physical network interfaces
  systemd.network.networks."40-physical" = {
    matchConfig = { Name = lib.mkForce "enp* eth* wlp* wlan*"; };
    networkConfig = { DHCP = "yes"; };
  };
}
