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
          [ -f ${cfg.urlsFile} ] || exit 1
        
          ${pkgs.parallel}/bin/parallel ${pkgs.curl}/bin/curl < ${cfg.urlsFile} |\
            ${pkgs.jq}/bin/jq 'if (.ok != true) then error(.error) else .msg end'
        '';
      };
      requires = [ "network.target" ];
      wantedBy = [ "default.target" ];
    };

    # Automatic updates
    systemd.timers."dns-records-update" = {
      wants = [ "dns-records-update.service" ];
      timerConfig = {
        OnCalendar = cfg.timer;
        Persistent = "true";
      };
    };
  };
}
