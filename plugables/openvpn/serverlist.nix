{ config, pkgs, lib, ... }:
{
  # Add OpenVPN servers, currently only works on one system
  services.openvpn.servers = {
    mullvadAT = { 
      config = builtins.readFile ../../private/openvpn/mullvad/mullvad_at.conf;
      updateResolvConf = true;
      autoStart = true;
    };
    mullvadHU = { 
      config = builtins.readFile ../../private/openvpn/mullvad/mullvad_hu.conf;
      updateResolvConf = true;
      autoStart = false;
    };
  };

  powerManagement.resumeCommands = ''
  PATH=$PATH:${pkgs.systemd}/bin:${pkgs.gnugrep}/bin:${pkgs.bash}/bin /etc/nixos/nixos-config/files/restart-openvpn.sh
  '';
}
