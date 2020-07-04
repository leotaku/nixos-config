{ lib, pkgs, config, options, ... }:
with lib;
let
  cfg = config.fleet;
  genMachines = machines:
    filter (v: !isNull v) (mapAttrsToList genMachine machines);
  genMachine = name:
    { hostName, system, maxJobs, speedFactor, supportedFeatures
    , mandatoryFeatures }:
    if name == config.networking.hostName then
      null
    else {
      sshUser = "fleet-builder";
      sshKey = "/home/fleet-builder/.ssh/id_rsa";
      hostName = if isNull hostName then name else hostName;
      inherit system maxJobs speedFactor;
      inherit supportedFeatures mandatoryFeatures;
    };
in {
  options.fleet = {
    enable = mkEnableOption "fleet remote building configuration";
    base = mkOption {
      description = "Base dir where SSH keys are found.";
      type = types.str;
    };
    machines = mkOption {
      description = "Definition of builder machines.";
      type = with types;
        attrsOf (submodule ({ config, ... }: {
          options = {
            hostName = mkOption {
              type = nullOr str;
              description = ''
                Host name used to connect to the given machine.
                Default means "''${name}".
              '';
              default = null;
            };
            system = mkOption {
              type = str;
              description = "Nix system type of the given machine.";
            };
            maxJobs = mkOption {
              type = int;
              default = 4;
              description =
                "Maximum number of jobs to be run in parallel on the given machine.";
            };
            speedFactor = mkOption {
              type = int;
              default = 4;
              description =
                "Relative weight of the compute strength of the given machine.";
            };
            supportedFeatures = mkOption {
              type = listOf str;
              default = [ ];
              description = "List of supported features of the given machine.";
            };
            mandatoryFeatures = mkOption {
              type = listOf str;
              default = [ ];
              description = "List of mandatory features of the given machine.";
            };
          };
        }));
    };
  };

  config = lib.mkIf (cfg.enable == true) ({
    users.users.fleet-builder = {
      isNormalUser = true;
      extraGroups = [ ];
    };
    nix = {
      trustedUsers = [ "fleet-builder" ];
      buildMachines = genMachines cfg.machines;
      extraOptions = "builders-use-substitutes = true";
    };
  } // (
    # Only offer secrets if morph is used
    if hasAttr "deployment" options then {
      deployment = {
        substituteOnDestination = true;
        secrets = {
          "fleet-builder-id_rsa" = {
            source = "${cfg.base}/id_rsa";
            destination = "/home/fleet-builder/.ssh/id_rsa";
            owner.user = "fleet-builder";
            owner.group = "nogroup";
            action =
              [ "chown" "fleet-builder:nogroup" "/home/fleet-builder/.ssh" ];
          };
          "fleet-builder-id_rsa_pub" = {
            source = "${cfg.base}/id_rsa.pub";
            destination = "/home/fleet-builder/.ssh/id_rsa.pub";
            owner.user = "fleet-builder";
            owner.group = "nogroup";
          };
          "fleet-builder-authorized_keys" = {
            source = "${cfg.base}/id_rsa.pub";
            destination = "/home/fleet-builder/.ssh/authorized_keys";
            owner.user = "fleet-builder";
            owner.group = "nogroup";
          };
        };
      };
    } else
      { }));
}
