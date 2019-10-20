{ config, pkgs, lib, ... }:
{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.99.8.69/32" "fc00:bbbb:bbbb:bb01::845/128" ];
      privateKeyFile = "/etc/nixos/nixos-config/private/wireguard-pk.txt";
      allowedIPsAsRoutes = false;

      peers = [
        {
          publicKey = "iE7SukqspT1UtQxce9S5plJ+GpAXdl4zG2oqpbhzvAw=";
          endpoint = "185.210.219.242:51820";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
