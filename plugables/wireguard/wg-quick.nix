{ config, pkgs, lib, ... }:
let
  wg = (import ./mullvad.nix pkgs).networking.wireguard.interfaces.wg0;
  address = wg.ips;
  privateKeyFile = wg.privateKeyFile;
  peers = wg.peers;
in
{
  networking.wg-quick.interfaces = {
    wg0 = {

      # postUp = ''
      #   ${pkgs.iptables}/bin/iptables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT &&\
      #   ${pkgs.iptables}/bin/ip6tables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
      # '';
      # preDown = ''
      #   ${pkgs.iptables}/bin/iptables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT &&\
      #   ${pkgs.iptables}/bin/ip6tables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
      # '';

      dns = [ "193.138.218.74" ];
      inherit address privateKeyFile peers;
    };
  };

  systemd.services.wg-quick-wg0 = {
    wantedBy = lib.mkIf true (lib.mkForce []);
  };
}
