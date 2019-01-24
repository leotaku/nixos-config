{config, pkgs, ... }:
let
  users = [ "leo" ];
  runAt = timer: {
    paths = map (u: "/home/${u}") users;
    repository = "rest:https://restic.le0.gs";
    passwordFile = "/etc/nixos/nixos-config/private/restic/default-repo-pass.txt";
    extraBackupArgs = [ "--exclude '.cache'" ];
    timerConfig = timer;
  };
in
  {
    imports = [ ../../modules/restic-fix.nix ];

    services.restic-fix.backups = {
      "home-bidaily"  = runAt { OnCalendar = [ "*-*-* 11:00" "*-*-* 22:00" ]; Persistent = "true"; };
    };
  }
