{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.wg-quicker;
  kernel = config.boot.kernelPackages;

  genService = name: target: {
    description = "${name} wg-quick WireGuard Tunnel";
    requires = [ "network-online.target" ];
    after = [ "network.target" "network-online.target" ];
    wantedBy = [ "default.target" ];
    environment.DEVICE = name;
    path = [ pkgs.kmod pkgs.wireguard-tools ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${optionalString (!config.boot.isContainer) "modprobe wireguard"}
      wg-quick up "${target}"
    '';

    preStop = ''
      wg-quick down "${target}"
    '';
  };

  createServices = map (target:
    let
      trail = last (splitString "/" target);
      name = elemAt (splitString "." trail) 0;
    in nameValuePair "wg-quicker-${name}" (genService name target));

in {
  ### Options
  options.services.wg-quicker = {
    setups = mkOption {
      description = "List of Wireguard configuration files.";
      default = [ ];
      type = with types; listOf str;
    };
  };

  ### Implementation
  config = mkIf (cfg.setups != { }) {

    # Only add the Wireguard kernel package on Linux versions where it
    # is not already built-in.
    boot.extraModulePackages =
      if kernel.wireguard == null then [ ] else [ kernel.wireguard ];
    boot.kernelModules = [ "wireguard" ];

    environment.systemPackages = [ pkgs.wireguard-tools ];

    # This is forced to false for now because the default "--validmark" rpfilter we apply on reverse path filtering
    # breaks the wg-quick routing because wireguard packets leave with a fwmark from wireguard.
    networking.firewall.checkReversePath = false;

    ## Service
    systemd.services = listToAttrs (createServices cfg.setups);
  };
}
