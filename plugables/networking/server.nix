{ config, pkgs, lib, ... }:

{
  imports = [
    ./shared.nix
    ../../modules/wg-quicker.nix
  ];

  # Enable NetworkManager + iwd
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
  };

  # TODO: Networkd for networking
  networking.useNetworkd = false;

  # TODO: Properly configure DHCP for netword
  networking.useDHCP = false;
  networking.interfaces."enp8s0".useDHCP = true;
  networking.interfaces."enp7s0".useDHCP = true;
  networking.interfaces."enp6s0".useDHCP = true;

  # Fix netword issue
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart =
    lib.mkIf config.networking.useDHCP (
      lib.mkForce [
        "" # clear old command
        "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --ignore enp8s0 --ignore enp6s0"
      ]
    );

  # Enable Wireguard VPN
  services.wg-quicker = {
    setups = {
      "vpn" = {
        enable = true;
        path = builtins.toString ../../private/mullvad/mullvad-ch4.conf;
      };
    };
  };
}
