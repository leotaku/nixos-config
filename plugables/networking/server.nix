{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Use systemd-networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;

  # Setup all physical network interfaces
  networking.interfaces."physical".useDHCP = true;
  systemd.network.networks."40-physical" = {
    matchConfig = { Name = lib.mkForce "enp* eth* wlp* wlan*"; };
  };

  # Fix systemd-networkd-wait-online issue
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart =
    lib.mkIf config.networking.useNetworkd (lib.mkForce [
      "" # clear old command
      "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --any"
    ]);
}
