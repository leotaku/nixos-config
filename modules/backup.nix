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
  backupscript = pkgs.writeShellScriptBin "backup" (
    lib.concatStrings (
      lib.mapAttrsToList (n: v: "export ${n}=${v}\n") (
        config.systemd.services.restic-backups-backup-module.environment
      ) ++ config.systemd.services.restic-backups-backup-module.serviceConfig.ExecStart
        ++ [ " $@" ]
    ));
  supportscript = pkgs.writeShellScriptBin "backuptool" (
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: "export ${n}=${v}") (
        lib.filterAttrs (n: _: n != "PATH")
        config.systemd.services.restic-backups-backup-module.environment
      ) ++ [ (pkgs.restic + "/bin/restic $@") ]
    ));
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
      type = types.str;
      description =
        "Location of a file containing the password needed for accessing the restic repository.";
    };

    user = mkOption {
      type = types.str;
      default = "root";
      description = "User account under which the backup runs.";
    };

    extraArgs = mkOption {
      type = with types; listOf str;
      default = [ ];
      description = "Extra flags to pass to the restic backup command.";
    };

    paths = mkOption {
      type = types.listOf backupPath;
      default = [ ];
      description = "List of paths to back up.";
    };
  };

  config = mkIf cfg.enable {
    # Enable a restic backup service
    services.restic.backups."backup-module" = mkIf cfg.enable {
      paths = map (p: p.path) cfg.paths;
      user = cfg.user;
      repository = cfg.repository;
      passwordFile = cfg.passwordFile;
      extraBackupArgs = concatLists (
        map (p: (map (e: "--exclude='${p.path}/${e}'") p.exclude))
        cfg.paths
      ) ++ cfg.extraArgs;
      timerConfig = {
        OnCalendar = cfg.timer;
        Persistent = true;
      };
    };

    # Include the restic package and backup script in the global environment
    environment.systemPackages = [ pkgs.restic backupscript supportscript ];
  };
}
