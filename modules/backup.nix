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
  services = lib.filterAttrs (name: _: lib.hasPrefix "restic" name)
    config.systemd.services;
  generateScript = name: service:
    let filename = "backuptool-" + lib.last (lib.splitString "-" name);
    in pkgs.writeShellScriptBin filename ''
      export RESTIC_REPOSITORY="${service.environment.RESTIC_REPOSITORY}"
      export RESTIC_PASSWORD_FILE="${service.environment.RESTIC_PASSWORD_FILE}"
      export RESTIC_CACHE_DIR="/var/cache/${name}"
      ${pkgs.restic}/bin/restic "$@"
    '';
  scripts = lib.mapAttrsToList generateScript services;
in {
  options.backup.jobs = mkOption {
    type = with types;
      listOf (submodule (_: {
        options = {
          enable = mkEnableOption "backup service based on restic";
          timer = mkOption {
            type = types.unspecified;
            default = [ "daily" ];
            description = "When to run the backup.";
          };
          repository = mkOption {
            type = types.str;
            example = "rest:http://example.com:8000";
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
      }));
  };

  config = {
    # Enable a Restic backup service
    services.restic.backups = listToAttrs (imap (n: cfg: {
      name = "backup-module-" + builtins.toString n;
      value = mkIf cfg.enable {
        paths = map (p: p.path) cfg.paths;
        user = cfg.user;
        repository = cfg.repository;
        passwordFile = cfg.passwordFile;
        extraBackupArgs = concatLists
          (map (p: (map (e: "--exclude='${p.path}/${e}'") p.exclude)) cfg.paths)
          ++ cfg.extraArgs;
        timerConfig = {
          OnCalendar = cfg.timer;
          Persistent = true;
        };
      };
    }) cfg.jobs);

    # Include the Restic package and backup script in the global environment
    environment.systemPackages = [ pkgs.restic ] ++ scripts;
  };
}
