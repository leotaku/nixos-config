{ config, pkgs, lib, ... }:

{
  # Use firewall per default
  networking.firewall.enable = true;
  networking.firewall.package = pkgs.iptables-nftables-compat;

  # Use trusted DNS server
  # 1: https://mullvad.net/de/help/dns-leaks/
  # 0: https://developers.cloudflare.com/1.1.1.1/
  networking.nameservers = [ "193.138.218.74" ];

  # Use systemd-resolved instead of dhcpcd
  # TODO: Maybe enable DoT when it becomes safe
  # TODO: Investigate why DNSSec never works
  # TODO: Investigate why IPv6 breaks everything
  networking.dhcpcd.enable = false;
  networking.enableIPv6 = true;
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" ];
    dnssec = "allow-downgrade";
  };

  # Wireguard support
  nixpkgs.overlays = [
    (self: super: {
      wireguard-tools =
        super.wireguard-tools.override { openresolv = self.systemd; };
    })
  ];

  # Fix systemd-networkd-wait-online issue
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart =
    lib.mkIf config.networking.useNetworkd (lib.mkForce [
      "" # clear old command
      "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --any"
    ]);
}
