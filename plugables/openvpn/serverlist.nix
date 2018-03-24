{ config, pkgs, lib, ... }:
{
  # Add OpenVPN servers, currently only works on one system
  services.openvpn.servers = {
    mullvadAT = { 
      config = builtins.readFile ../../private/openvpn/mullvadAT/mullvad_at.conf;
      updateResolvConf = true;
      autoStart = false;
    };
    mullvadHU = { 
      config = builtins.readFile ../../private/openvpn/mullvadHU/mullvad_hu.conf;
      updateResolvConf = true;
      autoStart = false;
    };
  };

  powerManagement.resumeCommands = ''
    ${pkgs.bash}/bin/bash -c "${pkgs.systemd}/bin/systemctl restart `${pkgs.systemd}/bin/systemctl --plain list-unit-files | ${pkgs.gnugrep}/bin/grep 'enabled *$' | ${pkgs.gnugrep}/bin/grep -o 'openvpn[^ ]*`"
  '';
}
