{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  # Networking
  services.connman = {
    enable = true;
    wifi.backend = "wpa_supplicant";
    networkInterfaceBlacklist =
      [ "docker" "vmnet" "vboxnet" "virbr" "ifb" "ve" "vnet" "eth" "wlan" ];
    extraFlags = [ "--nodnsproxy" ];
    extraConfig = ''
      [General]
      PreferredTechnologies=ethernet,wifi
    '';
  };
  networking.useDHCP = false;

  # Networking GUI
  systemd.user.services."connman-gtk" = {
    enable = true;
    serviceConfig = {
      ExecPreStart = pkgs.coreutils + "/bin/sleep 3";
      ExecStart = pkgs.connman-gtk + "/bin/connman-gtk --tray";
      partOf = "graphical-session.target";
      Type = "simple";
    };
    wantedBy = [ "default.target" ];
    after = [ "graphical-session.target" "network.target" ];
  };

  # Enable Avahi
  services.avahi = {
    enable = true;
    nssmdns = false;
    publish.enable = false;
  };
}
