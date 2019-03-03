# Networking using NetworkManager + iwd
# + custom boot/lid events for a smooth
# laptop networking experience

# likely the best option until connman 
# is more widely adopted and gets better iwd
# support

{ config, pkgs, lib, ... }:
{
  networking.networkmanager = {
    enable = true;
    dhcp = "internal";
    wifi = {
      backend = "iwd";
    };
  };

  services.acpid = {
    enable = true;
    handlers = {
      "lid-close-nm" = {
        event = "button/lid LID close";
        action = "${pkgs.systemd}/bin/systemctl stop network-manager.service";
      };
      "lid-open-nm" = {
        event = "button/lid LID open";
        action = "${pkgs.systemd}/bin/systemctl restart network-manager.service";
      };
    };
  };

  systemd.services."restart-nm-after-start" = {
    description = "Restart NetworkManager";
    after = [ "network-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
    ${pkgs.systemd}/bin/systemctl restart network-manager.service
    '';
    serviceConfig.Type = "oneshot";
  };
}
