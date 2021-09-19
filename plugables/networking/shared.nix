{ config, pkgs, lib, ... }:

{
  # Use systemd-networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;

  # FIXME: Nftables is better but messes up virtualization
  networking.firewall.package = pkgs.iptables;

  # Use trusted DNS server
  # 0: https://mullvad.net/de/help/dns-leaks/
  # 1: https://developers.cloudflare.com/1.1.1.1/
  networking.nameservers = [ "1.1.1.1" ];

  # Use systemd-resolved instead of DHCPCD
  # TODO: Maybe enable DoT when it becomes safe
  # TODO: Investigate why DNSSec never works
  # TODO: Investigate why IPv6 breaks everything
  networking.dhcpcd.enable = false;
  networking.enableIPv6 = true;
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [ "8.8.8.8" ];
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
      "" # Empty to clear old ExecStart values
      "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --any"
    ]);
}
