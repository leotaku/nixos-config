# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{ 
  imports = [
    # Import plugable configurations
    ../../plugables/avahi/default.nix
    #../plugables/transmission/default.nix
    #../plugables/backup/restic-all.nix
    #../plugables/email/postfix-queue.nix
    # Import custom modules
    ../../modules/backup.nix
    ../../modules/wg-quicker.nix
    # Import package collections
    ../../plugables/packages/large.nix
    # Test stuff
    #../containers/test.nix
  ];

  nix.useSandbox = true;

  # Nixpkgs settings
  nixpkgs.overlays = [ (import ../../pkgs) ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.virtualbox.enableExtensionPack = false;

  # Override default nixos stuff
  boot.loader.timeout = 10;
  boot.plymouth.enable = true;

  # less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  boot.earlyVconsoleSetup = true;

  # Networking
  networking.hostName = "nixos-laptop"; # Define your hostname.

  # Enable Networkmanager + iwd
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
  };

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "wlp3s0";

  # Use trusted DNS server
  # 1: https://snopyta.org/service/dns/index.html
  # 2: https://mullvad.net/de/help/dns-leaks
  networking.nameservers = [ "95.216.24.230" "193.138.218.74" ];

  # Use resolved instead of dhcpcd, as it respects resolv.conf
  # TODO: Maybe enable DoT when it becomes safe
  # TODO: Investigate why DNSSec never works
  networking.dhcpcd.enable = false;
  services.resolved = {
    enable = true;
    fallbackDns = [ "0.0.0.0" ];
    dnssec = "allow-downgrade";
  };

  # Enable Wireguard VPN
  services.wg-quicker = {
    available = true;
    setups = {
      "ch" = ../../private/mullvad/ch.conf;
    };
  };

  # Select internationalisation properties.
  i18n = {
    # TODO: find how to increase console font size
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";
  
  environment.systemPackages = with pkgs; [
    # Laptop
    acpi
    # Control
    pulsemixer
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
  services.tumbler.enable = true;

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

  # URxvt daemon
  services.urxvtd = {
    enable = true;
    package = pkgs.rxvt-unicode-custom;
  };

  # Basic xdg support
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
  ];

  # SDDM
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "haze";
    extraConfig = ''
      [Autologin]
      Relogin=false
      Session=
      User=

      [General]
      InputMethod=
      
      [Theme]
      ThemeDir=${pkgs.sddm-themes}/share/sddm/themes
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

  virtualisation.docker.enable = true;
  services.flatpak.enable = true;

  # Add wireshark permissions
  programs.wireshark = { 
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Backup important directories
  backup = {
    enable = true;
    timer = [ "*-*-* 11:00" "*-*-* 22:00" ];
    repository = "rest:http://le0.gs:8000";
    passwordFile = ../../private/restic-pw;
    paths = [
      {
        path = "/home/leo";
        exclude = [
          "large"          
          ".maildir/.notmuch"
          ".local/share/flatpak"
          ".cache/mozilla/firefox/dev-edition-default/cache2"
        ];
      }
    ];
  };

  # Run locatedb every hour
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };
  
  # Fix broken lid-suspend
  services.logind.lidSwitch = "ignore";
  services.acpid.enable = true;
  services.acpid.logEvents = true;
  services.acpid.handlers = {
    "lid-close-suspend" = {
      event = "button/lid LID close";
      action = ''
      ${pkgs.systemd}/bin/loginctl lock-sessions
      sleep 2
      ${pkgs.systemd}/bin/systemctl start suspend.target
      '';
    };
  };
}
