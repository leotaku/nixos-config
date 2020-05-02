{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.emacs-server;
in {
  options.services.emacs-server = {
    enable = mkEnableOption "the Emacs daemon";
    package = mkOption {
      type = types.package;
      description = "The Emacs package to use for running the daemon.";
    };
    shell = mkOption {
      type = types.str;
      description = "The shell used for starting Emacs.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.emacs = {
      Unit = {
        Description = "Emacs: the extensible, self-documenting text editor";
        Documentation =
          "info:emacs man:emacs(1) https://gnu.org/software/emacs/";

        # Avoid killing the Emacs session, which may be full of
        # unsaved buffers.
        X-RestartIfChanged = false;
      };

      Service = {
        ExecStart =
          "${cfg.shell} 'exec ${cfg.package}/bin/emacs --fg-daemon'";
        ExecStop = "${cfg.package}/bin/emacsclient --eval '(kill-emacs)'";
        Restart = "on-failure";
      };

      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
