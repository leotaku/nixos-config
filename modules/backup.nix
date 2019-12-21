{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.backup;
  backupPath = types.submodule {
    options = {
      path = mkOption {
        type = types.str;
        description = "Path that should be included in the backup.";
      };
      exclude = mkOption {
        type = with types; listOf str;
        description =
          "Paths that should be excluded from the backup, relative to the value of path.";
      };
    };
  };
  backupscript = (
    pkgs.writeShellScriptBin "backup" (lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: "export ${n}=${v}")
      config.systemd.services.restic-backups-backup-module.environment ++ [
        (config.systemd.services.restic-backups-backup-module.serviceConfig.ExecStart + " $@")
      ]
    ))
  );
  supportscript = (
    pkgs.writeShellScriptBin "backuptool" (
      (lib.concatStringsSep "\n" (
        lib.mapAttrsToList (n: v: "export ${n}=${v}")
        config.systemd.services.restic-backups-backup-module.environment ++ [
          (pkgs.restic + "/bin/restic $@")
        ]
      ))));
in {
  options.backup = {
    enable = mkEnableOption "backup service based on restic";

    timer = mkOption {
      type = types.unspecified;
      default = [ "daily" ];
      description = "When to run the backup.";
    };

    repository = mkOption {
      type = types.str;
      example = "rest:http://le0.gs:8000";
      description = "Location of the restic server.";
    };

    passwordFile = mkOption {
      type = types.path;
      description =
        "Location of a file containing the password needed for accessing the restic repository.";
    };

    user = mkOption {
      type = types.str;
      default = "root";
      description = "As which user the backup should run.";
    };

    paths = mkOption {
      type = types.listOf backupPath;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = lib.pathExists cfg.passwordFile;
      message = "backup: Password file does not exist!";
    }];

    # Enable a restic backup service
    services.restic.backups."backup-module" = mkIf cfg.enable {
      paths = map (p: p.path) cfg.paths;
      user = cfg.user;
      repository = cfg.repository;
      passwordFile = builtins.toString cfg.passwordFile;
      extraBackupArgs = concatLists (map
        (p: (map (e: concatStrings [ "--exclude " p.path "/" e ]) p.exclude))
        cfg.paths);
      timerConfig = {
        OnCalendar = cfg.timer;
        Persistent = "true";
      };
    };

    # Include the restic package and backup script in the global environment
    environment.systemPackages = [ pkgs.restic backupscript supportscript ];
  };
}
