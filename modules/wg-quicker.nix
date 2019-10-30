{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.wg-quicker;
  kernel = config.boot.kernelPackages;

  genDir = file:
    pkgs.writeTextFile {
      name = "config-${cfg.interface}";
      executable = false;
      destination = "/${cfg.interface}.conf";
      text = lib.fileContents file;
    };
  genFile = file: (genDir file) + "/${cfg.interface}.conf";
  genService = name: file: {
    description = "${name} wg-quick WireGuard Tunnel";
    requires = [ "network-online.target" ];
    after = [ "network.target" "network-online.target" ];
    wantedBy = [ ];
    environment.DEVICE = cfg.interface;
    path = [ pkgs.kmod pkgs.wireguard-tools ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${optionalString (!config.boot.isContainer) "modprobe wireguard"}
      wg-quick up ${genFile file}
    '';

    preStop = ''
      wg-quick down ${genFile file}
    '';
  };

  createServices = (mapAttrs' (name: submodule:
    nameValuePair "wg-quicker-${name}" (genService name submodule)));

in {
  ### Options
  options.services.wg-quicker = {
    available = mkEnableOption "Make Wireguard instances available.";

    setups = mkOption {
      description = "Attrset of Wireguard configurations.";
      type = with types; attrsOf path;

      # (submodule {
      #   conf = {
      #     description =
      #       "Location of the configuration file for this Wireguard instance.";
      #     type = types.path;
      #   };
      # });
    };

    interface = mkOption {
      description = "Name for the Wireguard interface";
      type = types.str;
      default = "wg0";
    };
  };

  ### Implementation
  config = lib.mkIf cfg.available {

    boot.extraModulePackages = [ kernel.wireguard ];
    environment.systemPackages = [ pkgs.wireguard-tools ];
    # This is forced to false for now because the default "--validmark" rpfilter we apply on reverse path filtering
    # breaks the wg-quick routing because wireguard packets leave with a fwmark from wireguard.
    networking.firewall.checkReversePath = false;

    ## Service
    systemd.services = createServices cfg.setups;
  };
}
