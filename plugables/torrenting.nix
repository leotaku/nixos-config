{ config, pkgs, lib, ... }:

{
  imports = [ ../modules/wg-quicker.nix ];

  # Aria2 server
  services.aria2 = {
    enable = true;
    downloadDir = config.fileSystems.raid1x5tb.mountPoint + "/download";
    listenPortRange = map (n: {
      from = n;
      to = n;
    }) [ 6585 9395 11551 14128 ];
    openPorts = false;
    extraArguments = lib.concatStringsSep " " [
      "--rpc-listen-all=false"
      "--remote-time=true"
      "--max-concurrent-downloads=200"
      "--save-session-interval=30"
      "--force-save=false"
      "--input-file=/var/lib/aria2/aria2.session"
      "--enable-dht=true"
      "--dht-listen-port=22327"
      "--seed-ratio=3.0"
    ];
    # NOTE: Irrelevant, we are protected by HTTP authentication
    rpcSecret = "aria2rpc";
  };

  # Override default networking
  systemd.network.networks."40-physical" = {
    routingPolicyRules = [
      {
        routingPolicyRuleConfig = {
          Table = "main";
          SourcePort = 6800;
          Priority = 1000;
        };
      }
      {
        routingPolicyRuleConfig = {
          Table = "2002";
          User = "aria2";
          Priority = 1001;
        };
      }
    ];
    routes = [{
      routeConfig = {
        Table = "2002";
        Destination = "0.0.0.0/0";
        Type = "prohibit";
        Metric = 1;
      };
    }];
  };

  # Disable using DNS servers from DHCP for vpn interface
  systemd.network.networks."30-wireguard" = {
    matchConfig = { Name = lib.mkForce "vpn"; };
    dhcpV4Config = { UseDNS = false; };
    dhcpV6Config = { UseDNS = false; };
  };

  # Season downloads
  services.sonarr.enable = true;

  # Shared group for downloaded stuff
  users.groups.media = { };
  services.sonarr.group = "media";
  users.users."aria2".group = lib.mkForce "media";

  # Enable Wireguard VPN
  services.wg-quicker = {
    setups = [ "/etc/wireguard/vpn.conf" ];
  };
}
