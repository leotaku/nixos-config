{ config, lib, pkgs, ... }:

{
  systemd.user.services.simple-compton = {
    Unit = {
      Description = "Compton X11 compositor";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        "${pkgs.compton-git}/bin/compton";
      Restart = "always";
      RestartSec = 3;
    } // {
      # Temporarily fixes corrupt colours with Mesa 18.
      Environment = [ "allow_rgb10_configs=false" ];
    };
  };
}
