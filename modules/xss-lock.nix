{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.xss-lock;
in {
  options.services.xss-lock = {
    enable = mkEnableOption "screen locking and suspension using xss-lock";

    command = mkOption {
      type = types.str;
      description = "Locker command to run.";
    };
    times = mapAttrs (n: v: mkOption {
      type = types.int;
      description = "When the ${n} X event should be triggered in seconds. 0 means to never trigger the event.";
      default = v;
    }) {
      lock = 600;
      period = 60;
      standby = 1200;
      suspend = 1200;
      off = 1200;
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [ ];

    systemd.user.services."xss-lock" = {
      Unit = {
        Description="Auto lock";
        PartOf="graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart= "${pkgs.xss-lock}/bin/xss-lock -v -l -s $XDG_SESSION_ID -- ${cfg.command}";
      };
      Install = {
        WantedBy= [ "graphical-session.target" ];
      };
    };

    systemd.user.services."xset-timings" = {
      Unit = {
        Description="Set xset timings";
        PartOf="graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = with pkgs.xorg;
          "${xset}/bin/xset s ${builtins.toString cfg.times.lock} ${builtins.toString cfg.times.period};" +
          "${xset}/bin/xset dpms ${builtins.toString cfg.times.standby} ${builtins.toString cfg.times.suspend} ${builtins.toString cfg.times.off}";
      };
      Install = {
        WantedBy= [ "graphical-session.target" ];
      };
    };
  };
}
