{ config, pkgs, lib, ... }:

{
  # Use trusted DNS server
  # 1: https://snopyta.org/service/dns/index.html
  # 2: https://mullvad.net/de/help/dns-leaks
  networking.nameservers = [ "95.216.24.230" "193.138.218.74" ];

  # Use resolved instead of dhcpcd, as it respects resolv.conf
  # TODO: Maybe enable DoT when it becomes safe
  # TODO: Investigate why DNSSec never works
  networking.dhcpcd.enable = false;
  services.resolved = {
    enable = true;
    fallbackDns = [ "0.0.0.0" ];
    dnssec = "allow-downgrade";
  };

  # Wireguard support
  nixpkgs.overlays = [
    (self: super: {
      wireguard-tools =
        super.wireguard-tools.override { openresolv = self.systemd; };
    })
  ];
}
