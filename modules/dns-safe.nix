{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.services.dns-records-update;
in {
  options.services.dns-records-update = {
    enable = mkEnableOption "Automatically update DNS records";
    timer = mkOption {
      type = types.str;
      default = "01:00:00";
      description = "Interval at which the service is run (systemd time)";
    };
    urlsFile = mkOption {
      type = types.str;
      default = {};
      description = "File containing URLs to contact when service is run";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services."dns-records-update" = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-dns" ''
          set -e

          if [ -f "${cfg.urlsFile}" ]; then
              echo "DNS file exists!"
          else
              echo "DNS file does not exist. Exiting."
              exit 1
          fi
        
          ${pkgs.parallel}/bin/parallel "${pkgs.curl}/bin/curl {} | ${pkgs.jq}/bin/jq 'if (.ok == true) then .msg else error(.msg) end'" < ${cfg.urlsFile}
        '';
      };
      requires = [ "network.target" ];
      wantedBy = [ "default.target" ];
    };

    # Automatic updates
    systemd.timers."dns-records-update" = {
      enable = true;
      wants = [ "dns-records-update.service" ];
      timerConfig = {
        OnCalendar = cfg.timer;
        Persistent = "true";
      };
    };
  };
}
