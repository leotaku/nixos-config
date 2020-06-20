{ config, pkgs, lib, ... }:

{
  imports = [ ./mdns.nix ];

  # Use trusted DNS server
  # 1: https://mullvad.net/de/help/dns-leaks/
  # 0: https://developers.cloudflare.com/1.1.1.1/
  networking.nameservers = [ "193.138.218.74" ];

  # Use resolved instead of dhcpcd, as it respects resolv.conf
  # TODO: Maybe enable DoT when it becomes safe
  # TODO: Investigate why DNSSec never works
  networking.dhcpcd.enable = false;
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
}
