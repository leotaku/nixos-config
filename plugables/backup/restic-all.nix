{config, pkgs, ... }:
let
  users = [ "leo" ];
  runAt = timer: {
    paths = map (u: "/home/${u}") users;
    repository = "rest:http://le0.gs:8000";
    passwordFile = "/etc/nixos/nixos-config/private/restic/default-repo-pass.txt";
    extraBackupArgs = [ 
      "--exclude '.cache'" 
      "--exclude='.mozilla'"
      "--exclude='.weechat'" 
      "--exclude='.local/share/flatpak'"
      "--exclude='.maildir/.notmuch'"
    ];
    timerConfig = timer;
  };
in
{
  services.restic.backups = {
    "home-bidaily" = runAt { OnCalendar = [ "*-*-* 11:00" "*-*-* 22:00" ]; Persistent = "true"; };
  };
}
