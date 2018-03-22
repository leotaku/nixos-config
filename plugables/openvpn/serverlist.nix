{ config, pkgs, lib, ... }:
{
  # Add OpenVPN servers, currently only works on one system
  services.openvpn.servers = {
    mullvadAT = { 
      config = builtins.readFile ../../private/openvpn/mullvad_at.conf;
      updateResolvConf = true;
    };
  };

  powerManagement.resumeCommands = ''
    ${pkgs.systemd}/bin/systemctl restart openvpn-mullvadAT.service
  '';
}
