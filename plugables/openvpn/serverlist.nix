{ config, pkgs, lib, ... }:
{
  # Add OpenVPN servers, currently only works on one system
  services.openvpn.servers = {
    mullvadAT = { 
      config = '' config /home/leo/openvpn/mullvad_at.conf '';
      updateResolvConf = true;
    };
  };
}
