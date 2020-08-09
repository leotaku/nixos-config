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
      "--force-save=true"
      "--input-file=/var/lib/aria2/aria2.session"
      "--enable-dht=true"
      "--dht-listen-port=22327"
      "--seed-ratio=3.0"
    ];
    # NOTE: Irrelevant, we are protected by http-auth
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

  # Enable Wireguard VPN
  services.wg-quicker = {
    setups = {
      "vpn" = {
        enable = true;
        path = builtins.toString ../private/mullvad/mullvad-ch4.conf;
      };
    };
  };
}
