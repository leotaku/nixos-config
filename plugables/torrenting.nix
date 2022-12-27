{ config, pkgs, lib, ... }:

{
  imports = [ ../modules/variables.nix ../modules/wg-quicker.nix ];

  # Aria2 server
  services.aria2 = {
    enable = true;
    downloadDir = config.fileSystems.raid1x5tb.mountPoint + "/download";
    listenPortRange = map (n: {
      from = n;
      to = n;
    }) [ 55207 55293 55460 56395 ];
    openPorts = false;
    extraArguments = lib.concatStringsSep " " [
      "--rpc-listen-all=false"
      "--remote-time=true"
      "--max-concurrent-downloads=200"
      "--save-session-interval=30"
      "--force-save=false"
      "--input-file=/var/lib/aria2/aria2.session"
      "--enable-dht=true"
      "--dht-listen-port=58593"
      "--seed-ratio=3.0"
    ];
    # NOTE: Irrelevant, we are protected by HTTP authentication
    rpcSecret = "aria2rpc";
  };

  # Show AriaNg web interface using Nginx
  variables.virtualHosts."download" = {
    locations = {
      "/".root = pkgs.fetchzip {
        url =
          "https://github.com/mayswind/AriaNg/releases/download/1.3.2/AriaNg-1.3.2.zip";
        sha256 = "1ybn17fcgngzaq2166gmdihs7xrdkr6jifcnwm0sk9cfrzqv0r4d";
        stripRoot = false;
      };
      "/jsonrpc" = {
        proxyPass = "http://localhost:6800/jsonrpc";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-Host $host:$server_port;
          proxy_set_header X-Forwarded-Server $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        '';
      };
    };
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
    dhcpV4Config = { UseDNS = true; };
    dhcpV6Config = { UseDNS = true; };
  };

  # Enable Wireguard VPN
  services.wg-quicker.setups = [ "/etc/wireguard/vpn.conf" ];

  # Streaming server
  services.jellyfin.enable = true;

  # Forward Jellyfin to Nginx
  variables.virtualHosts."stream" = {
    locations = {
      "/" = {
        proxyPass = "http://localhost:8096/";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Protocol $scheme;
          proxy_set_header X-Forwarded-Host $http_host;
          proxy_buffering off;
        '';
      };
      "/socket" = {
        proxyPass = "http://localhost:8096/socket/";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Protocol $scheme;
          proxy_set_header X-Forwarded-Host $http_host;
        '';
      };
    };
  };

  # Season downloads
  services.sonarr.enable = true;

  # Forward Sonarr to Nginx
  variables.virtualHosts."tv" = {
    locations = {
      "/" = {
        proxyPass = "http://localhost:8989";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_redirect off;
          sub_filter '</head>' '<link rel="stylesheet" type="text/css" href="https://archmonger.github.io/Blackberry-Themes/Themes/Blackberry-Shadow/radarr.css"></head>';
          sub_filter_once on;
        '';
      };
    };
  };

  # Shared group for downloaded stuff
  users.groups.media = { };
  services.sonarr.group = "media";
  users.users."aria2".group = lib.mkForce "media";
}
