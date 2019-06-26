{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.services.dns-records-update;

  createServices =
    (mapAttrs' (n: url:
      nameValuePair ("dns-records-update-${n}")
      ({
        wantedBy = [ "dns-records-update.target" ];
        startAt = cfg.timer;
        serviceConfig.ExecStart = "${pkgs.curl}/bin/curl ${url}";
      })));
in {
  options.services.dns-records-update = {
    enable = mkEnableOption "Automatically update DNS records";
    timer = mkOption {
      type = types.string;
      default = "01:00:00";
      description = "Interval at which the service is run (systemd time)";
    };
    urls = mkOption {
      type = types.attrsOf types.string;
      default = {};
      description = "URLs to contact when service is run";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = createServices cfg.urls;
    systemd.targets.dns-records-update = {
      wantedBy = [ "multi-user.target" ];
    };
  };
}
