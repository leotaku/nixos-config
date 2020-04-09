{ config, lib, pkgs, ... }:

{
  systemd.user.services.picom = {
    Unit = {
      Description = "Compton X11 compositor";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = [
        (pkgs.picom + "/bin/picom --experimental-backends")
      ];
      Restart = "always";
      RestartSec = 3;
    };
  };
}
