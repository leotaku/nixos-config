{ lib, pkgs, config, options, ... }:
with lib;
let cfg = config.meshify;
in {
  options.meshify = {
    enable = mkEnableOption "Nebula private mesh network";
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Automatically open ports for Nebula in the firewall.";
    };
    servers = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          external = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = "External IPs or domain names of this server.";
          };
          internal = mkOption {
            type = types.str;
            description = "Internal mesh IP of this server.";
          };
        };
      });
      description = "Listing of servers in the Nebula mesh.";
    };
  };

  config = lib.mkIf (cfg.enable == true) ({
    # Open ports in firewall
    networking.firewall =
      lib.mkIf cfg.openFirewall { allowedUDPPorts = [ 4242 ]; };

    # Generate '.local' host entries
    networking.extraHosts = lib.concatStringsSep "\n"
      (lib.mapAttrsToList (n: v: "${v.internal} ${n}.local") cfg.servers);

    # Mutable Nebula for simple mesh network
    services.nebula.networks."meshify" = let
      hostName = config.networking.hostName;
      isLighthouse = lib.hasAttr hostName cfg.servers
        && (lib.getAttr hostName cfg.servers).external != [ ];
      staticHostMap = lib.mapAttrs' (_: v: {
        name = v.internal;
        value = map (v: v + ":4242") v.external;
      }) (lib.filterAttrs (_: v: v.external != [ ]) cfg.servers);
      rules = [{
        port = "any";
        proto = "any";
        host = "any";
      }];
    in {
      enable = true;
      ca = "/etc/nebula/ca.crt";
      cert = "/etc/nebula/host.crt";
      key = "/etc/nebula/host.key";
      inherit isLighthouse staticHostMap;
      lighthouses = if isLighthouse then
        [ ]
      else
        lib.mapAttrsToList lib.const staticHostMap;
      firewall.inbound = rules;
      firewall.outbound = rules;
      listen.port = 4242;
    };

    # Wait until online before starting Nebula VPN
    systemd.services."nebula@meshify" = {
      after = [ "network-online.target" ];
    };

    # Periodically restart Nebula VPN
    systemd.services."nebula-refresh" = {
      serviceConfig = {
        ExecStart = pkgs.systemd
          + "/bin/systemctl restart nebula@meshify.service";
        Type = "oneshot";
      };
      requires = [ "network.target" ];
    };

    systemd.timers."nebula-refresh" = {
      enable = true;
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = [ "daily" ];
        RandomizedDelaySec = "2h";
        Persistent = true;
      };
    };
  });
}
