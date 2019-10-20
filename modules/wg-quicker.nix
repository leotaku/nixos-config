{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.services.wg-quicker;
  kernel = config.boot.kernelPackages;

  genDir = pkgs.writeTextFile {
    name = "config-${cfg.interface}";
    executable = false;
    destination = "/${cfg.interface}.conf";
    text = lib.fileContents cfg.file;
  };
  genFile = genDir + "/${cfg.interface}.conf";
  
in {
  ### Options
  options.services.wg-quicker = {
    enable = mkEnableOption "Enable a Wireguard instance based on a wg-quick configuration.";
    available = mkEnableOption "Make available a Wireguard instance based on a wg-quick configuration.";

    file = mkOption {
      description = "File from which the wg-quick configuration is read.";
      type = types.str;
    };

    interface = mkOption {
      description = "Name for the Wireguard interface";
      type = types.str;
      default = "wg0";
    };
  };

  ### Implementation
  config = lib.mkIf (cfg.available or cfg.enable) {
    assertions = singleton {
      assertion = !(cfg.available && cfg.enable);
      message = "Having both 'enable' and 'avilable' in the wg-quicker service configuration is redundant.";
    };
    
    boot.extraModulePackages = [ kernel.wireguard ];
    environment.systemPackages = [ pkgs.wireguard-tools ];
    # This is forced to false for now because the default "--validmark" rpfilter we apply on reverse path filtering
    # breaks the wg-quick routing because wireguard packets leave with a fwmark from wireguard.
    networking.firewall.checkReversePath = false;

    ## Service
    systemd.services.wg-quicker = {
      description = "wg-quick WireGuard Tunnel";
      requires = [ "network-online.target" ];
      after = [ "network.target" "network-online.target" ];
      wantedBy = [ (lib.mkIf cfg.enable "multi-user.target") ];
      environment.DEVICE = cfg.interface;
      path = [ pkgs.kmod pkgs.wireguard-tools ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${optionalString (!config.boot.isContainer) "modprobe wireguard"}
        wg-quick up ${genFile}
      '';

      preStop = ''
        wg-quick down ${genFile}
      '';
    };
  };
}
