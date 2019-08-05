{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.backup;
  backupPath = types.submodule {
    options = {
      path = mkOption {
        type = types.string;
        description = "Path that should be included in the backup.";
      };
      exclude = mkOption {
        type = with types; listOf string;
        description = "Paths that should be excluded from the backup, relative to the value of path.";
      };
    };
  };
in
{
  options.backup = {
    enable = mkEnableOption "backup service based on restic";

    timer = mkOption {
      type = types.unspecified;
      default = [ "daily" ];
      description = "When to run the backup.";
    };
    
    repository = mkOption {
      type = types.string;
      example = "rest:http://le0.gs:8000";
      description = "Location of the restic server.";
    };

    passwordFile = mkOption {
      type = types.path;
      description = "Location of a file containing the password needed for accessing the restic repository.";
    };

    paths = mkOption {
      type = types.listOf backupPath;
      default = [];
    };
  };
  
  config = mkIf cfg.enable {
    # Enable a restic backup service
    services.restic.backups."backup-module" = mkIf cfg.enable {
      paths = map (p: p.path) cfg.paths;
      repository = cfg.repository;
      passwordFile = cfg.passwordFile;
      extraBackupArgs = concatLists
      (map (p: (map (e: concatStrings [ "--exclude " p.path "/" e ]) p.exclude)) cfg.paths);
      timerConfig = {
        OnCalendar = cfg.timer;
        Persistent = "true";
      };
    };

    # Include the restic package in the global environment
    environment.systemPackages = [ pkgs.restic ];
  };
}
