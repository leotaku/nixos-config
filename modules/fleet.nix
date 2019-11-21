{ lib, pkgs, config, options, ... }:
with lib;
let
  cfg = config.fleet;

  genMachines = mapAttrsToList genMachine;
  genMachine = hostName: {
    system, maxJobs, speedFactor, supportedFeatures, mandatoryFeatures, ...
  }: {
    sshUser = "fleet-builder";
    sshKey = "/home/fleet-builder/.ssh/id_rsa";
    inherit hostName system maxJobs speedFactor;
    inherit supportedFeatures mandatoryFeatures;
  };

  # FIXME: Find out how to generate hosts file
  genHosts = mapAttrs genHost;
  genHost = name: _: {
    hostNames = [ name ];
    publicKey = builtins.readFile "${cfg.base}/id_rsa.pub";
  };

in {
  options.fleet = {
    base = mkOption {
      description = "Base dir where SSH IDs are found.";
      type = types.str;
    };
    machines = mkOption {
      description = "Builder machines";
      type = with types; (
        attrsOf (submodule ({ config, ... }: {
          options = {
            system = mkOption { type = str; };
            maxJobs = mkOption {
              type = int;
              default = 4;
            };
            speedFactor = mkOption {
              type = int;
              default = 4;
            };
            supportedFeatures = mkOption {
              type = listOf str;
              default = [ ];
            };
            mandatoryFeatures = mkOption {
              type = listOf str;
              default = [ ];
            };
          };
        }))
      );
    };
  };

  config = lib.mkIf (cfg.machines != { }) ({
    users.extraUsers.fleet-builder = {
      isNormalUser = true;
      extraGroups = [ ];
    };

    nix = {
      trustedUsers = [ "fleet-builder" ];
      buildMachines = genMachines cfg.machines;
    };

  } // (
    # Only offer secrets if morph is used
    if !(hasAttr "deployment" options)
    then {}
    else {
      deployment.secrets = {
        "fleet-builder-id_rsa" = {
          source = "${cfg.base}/id_rsa";
          destination = "/home/fleet-builder/.ssh/id_rsa";
          owner.user = "fleet-builder";
          owner.group = "nogroup";
          action = [ "chown" "fleet-builder:nogroup" "/home/fleet-builder/.ssh" ];
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
    })
  );
}
