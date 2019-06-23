# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{ 
  imports = [
    # Import plugable configurations
    ../plugables/avahi/default.nix
    #../plugables/wireguard/wg-quick.nix
    #../plugables/transmission/default.nix
    #../plugables/backup/restic-all.nix
    #../plugables/email/postfix-queue.nix
    # Import package collections
    ../plugables/packages/base.nix
    ../plugables/packages/usability.nix
    # Enable throwaway account
    #../plugables/throwaway/default.nix
    # Test stuff
    #../containers/test.nix
  ];

  nix.useSandbox = true;
  nixpkgs.overlays = [ (import ../pkgs) ];

  # Override default nixos stuff
  boot.loader.timeout = 10;
  boot.plymouth.enable = true;

  # less verbose boot log
  #boot.consoleLogLevel = 3;
  #boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  #boot.earlyVconsoleSetup = true;

  # Networking
  networking.hostName = "nixos"; # Define your hostname.

  # Enable connman
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = false;
  networking.connman = {
    enable = true;
    enableVPN = true;
    extraConfig = ''
      [General]
      AllowHostnameUpdates=false
      PreferredTechnologies=ethernet,wifi
    '';
  };
  environment.etc."wpa_supplicant.conf".text = "";

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "wlp3s0";

  # Select internationalisation properties.
  i18n = {
    # TODO: find how to increase console font size
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Control
    pulsemixer
    connman-ncurses
    # Editors
    micro
    kakoune
    # Text-mode utils
    weechat
    # Files
    imagemagick
    ffmpeg-full
    pandoc
    # Shells
    zsh
    fish
  ];
  
  environment.variables = {
    EDITOR = "micro";
    TERMINAL = "urxvt";
    SHELL = "zsh";
    PAGER = "less";
  };
  
  # List programs that need nix wrappers
  programs.zsh.enable = true;
  programs.light.enable = true;

  # List simple services that you want to enable:
  services.upower.enable = true;
  powerManagement.enable = true;
  services.openssh.enable = true;
  services.cron.enable = false;
  services.netdata.enable = true;

  # Geoclue2 for redshift
  services.geoclue2 = {
    enable = true;
    enableDemoAgent = false;
    geoProviderUrl = "https://location.services.mozilla.com/v1/geolocate?key=16674381-f021-49de-8622-3021c5942aff";
  };

  # Printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplip gutenprint gutenprintBin splix ];

  # Needed for home-manager to work
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  # X11 windowing system.
  services.xserver.enable = true; 
  services.xserver.libinput.enable = true;
  services.xserver.wacom.enable = true;

  # SDDM
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "test";
    extraConfig = ''
      [Autologin]
      Relogin=false
      Session=
      User=

      [General]
      InputMethod=
      
      [Theme]
      ThemeDir=${pkgs.sddm_theme}/share/sddm/themes
    '';
  };

  # Sound
  hardware.pulseaudio.enable = true;

  # Steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;

  # Firewall configuration
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable virtuaisation/container technologies
  virtualisation.virtualbox.host = { 
    enable = false;
    #enableHardening = false; 
  };
  nixpkgs.config.virtualbox.enableExtensionPack = false;

  virtualisation.docker.enable = true;
  services.flatpak.enable = true;

  # Add wireshark permissions
  programs.wireshark = { 
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Run locatedb every hour
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };
}
