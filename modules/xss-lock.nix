{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.xss-lock;
  genCmd = name: cmd: pkgs.writeShellScript name (
    lib.concatMapStringsSep " " (s: "${s}") cmd
  );
in {
  options.services.xss-lock = {
    enable = mkEnableOption "screen locking and suspension using xss-lock";

    lockCmd = mkOption {
      type = with types; listOf str;
      description = "Locker command to run.";
    };
    notifyCmd = mkOption {
      type = with types; listOf str;
      description = "Notify command to run.";
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

    xsession.initExtra = with pkgs; ''
      ${xorg.xset}/bin/xset s ${builtins.toString cfg.times.lock} ${builtins.toString cfg.times.period}
      ${xorg.xset}/bin/xset dpms ${builtins.toString cfg.times.standby} ${builtins.toString cfg.times.suspend} ${builtins.toString cfg.times.off}
      ${xss-lock}/bin/xss-lock -n ${genCmd "notify-lock" cfg.notifyCmd} -- ${genCmd "lock" cfg.lockCmd} &
    '';
  };
}
