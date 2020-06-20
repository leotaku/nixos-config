{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.wg-quicker;
  kernel = config.boot.kernelPackages;

  genDir = name: path:
    pkgs.writeTextFile {
      name = "config-${name}";
      executable = false;
      destination = "/${name}.conf";
      text = fileContents path;
    };
  genFile = name: path: (genDir name path) + "/${name}.conf";
  genService = name: submodule: {
    description = "${name} wg-quick WireGuard Tunnel";
    requires = [ "network-online.target" ];
    after = [ "network.target" "network-online.target" ];
    wantedBy = mkIf submodule.enable [ "default.target" ];
    environment.DEVICE = name;
    path = [ pkgs.kmod pkgs.wireguard-tools ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${optionalString (!config.boot.isContainer) "modprobe wireguard"}
      wg-quick up "${genFile name submodule.path}"
    '';

    preStop = ''
      wg-quick down "${genFile name submodule.path}"
    '';
  };

  createServices = (mapAttrs' (name: submodule:
    nameValuePair "wg-quicker-${name}" (genService name submodule)));

in {
  ### Options
  options.services.wg-quicker = {
    setups = mkOption {
      description = "Attrset of Wireguard configurations.";
      default = { };
      type = with types;
        attrsOf (submodule {
          options = {
            enable = mkOption {
              type = bool;
              default = true;
              description = "Enable this Wireguard configuration.";
            };
            path = mkOption {
              type = str;
              description = "Path to the Wireguard configuration.";
            };
          };
        });
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
    systemd.services = createServices cfg.setups;
  };
}
