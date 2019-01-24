{ config, pkgs, lib, ... }:
let
  mkDir = (path:
  (pkgs.stdenv.mkDerivation {
    name = "fake-name";
    src = path;
    installPhase = ''
    mkdir $out
    cp * $out -r
    '';
  }));

  mullvad_dir = (mkDir ../../private/openvpn/mullvad);
in
{
  # Add OpenVPN servers, currently only works on one system
  services.openvpn.servers = {
    mullvadAT = { 
      config = ''
        config ${mullvad_dir}/mullvad_at.conf
        auth-user-pass ${mullvad_dir}/mullvad_userpass.txt
        ca ${mullvad_dir}/mullvad_ca.crt
        crl-verify ${mullvad_dir}/mullvad_crl.pem
      '';
      updateResolvConf = true;
      autoStart = false;
    };
  };

  # powerManagement.resumeCommands = ''
  # PATH=$PATH:${pkgs.systemd}/bin:${pkgs.gnugrep}/bin:${pkgs.bash}/bin ${./.}/restart-openvpn.sh
  # '';
}
