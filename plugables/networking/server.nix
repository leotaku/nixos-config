{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Enable firewall per default
  networking.firewall.enable = true;

  # Use predictable interface names
  networking.usePredictableInterfaceNames = true;

  # Setup all physical network interfaces
  systemd.network.networks."40-physical" = {
    matchConfig = { Name = lib.mkForce "enp* eth* wlp* wlan*"; };
    networkConfig = { DHCP = "yes"; };
  };
}
