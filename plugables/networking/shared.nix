{ config, pkgs, lib, ... }:

{
  # Use systemd-networkd for networking
  networking.useNetworkd = true;
  networking.useDHCP = false;
  services.nscd.enable = false;
  system.nssModules = lib.mkForce [ ];

  # Use trusted DNS server
  # 0: https://mullvad.net/de/help/dns-leaks/
  # 1: https://developers.cloudflare.com/1.1.1.1/
  networking.nameservers = [
    "8.8.8.8#dns.google"
    "8.8.4.4#dns.google"
    "1.1.1.1#1dot1dot1dot1.cloudflare-dns.com"
    "1.0.0.1#1dot1dot1dot1.cloudflare-dns.com"
  ];

  # Use systemd-resolved instead of DHCPCD
  networking.dhcpcd.enable = false;
  networking.enableIPv6 = true;
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [
      "194.242.2.2#dot.mullvad.net"
      "193.19.108.2#dot.mullvad.net"
      "193.138.218.74#dns.mullvad.net"
    ];
    dnssec = "true";
    extraConfig = "DNSOverTLS=opportunistic";
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
