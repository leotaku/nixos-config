# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    # Import plugable configurations
    ../../plugables/avahi/module.nix
    ../../plugables/xkeyboard/module.nix
    #../plugables/transmission/module.nix
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

  # Nixpkgs settings
  nixpkgs.overlays = [ (import ../../pkgs) ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.virtualbox.enableExtensionPack = false;

  # Override default nixos stuff
  boot.loader.timeout = 10;
  boot.plymouth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];

  # Select internationalisation properties.
  console = {
    # TODO: find how to increase console font size
    earlySetup = true;
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # DBUS user session
  services.dbus.socketActivated = true;

  # Networking
  networking.hostName = "nixos-laptop";

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wlp3s0";

  # Enable NetworkManager + iwd
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
  };

  # Enable Connman + iwd
  services.connman = {
    enable = false;
    wifi.backend = "iwd";
  };

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
      "ch" = builtins.toString ../../private/mullvad/ch.conf;
    };
  };

  environment.systemPackages = with pkgs; [
    # Laptop
    acpi
    powertop
    glxinfo
    tpacpi-bat
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

  # Global environment
  environment.variables = with pkgs; {
    EDITOR = neovim + "/bin/vim";
    TERMINAL = xterm + "/bin/xterm";
    PAGER = less + "/bin/less";
    TMPDIR = "/run/user/$UID";
  };
  environment.homeBinInPath = true;

  # Sysctl settings
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };

  # List programs that need nix wrappers
  programs.adb.enable = true;
  programs.gnome-disks.enable = true;
  programs.light.enable = true;
  programs.zsh.enable = true;

  # List simple services that you want to enable:
  powerManagement.enable = true;
  services.autorandr.enable = false;
  services.gvfs.enable = true;
  services.hardware.bolt.enable = true;
  services.netdata.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Geoclue2 for redshift
  services.geoclue2 = {
    enable = true;
    enableDemoAgent = false;
    geoProviderUrl =
      "https://location.services.mozilla.com/v1/geolocate?key=16674381-f021-49de-8622-3021c5942aff";
  };

  # Printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplip
    gutenprint
    gutenprintBin
    splix
  ];

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
  xdg.portal.gtkUsePortal = true;
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
  hardware.steam-hardware.enable = true;

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
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.anbox.enable = true;

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
    user = "leo";
    extraArgs = [ "--limit-upload" "5000" ];
    paths = [{
      path = "/home/leo";
      exclude = [
        "large"
        ".rustup"
        ".maildir/.notmuch"
        ".local/share"
        ".var/app"
        ".multimc"
        ".technic"
        ".cache"
        ".cargo"
        "**/target"
        "**/*.rlib"
        "**/*.rmeta"
        "**/*.o"
        "**/*.a"
        "**/*.so"
      ];
    }];
  };

  # Run locatedb every hour
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };

  # NixOS command-not-found functionality
  programs.command-not-found = {
    enable = true;
    dbPath = (import ../../sources/nix/sources.nix).nixexprs-unstable
      + "/programs.sqlite";
  };

  # Fix broken lid-suspend
  services.logind.lidSwitch = "ignore";
  services.acpid.enable = true;
  services.acpid.logEvents = true;
  services.acpid.handlers = {
    "lid-close" = {
      event = "button/lid LID close";
      action = ''
        ${pkgs.systemd}/bin/systemctl stop iwd.service
        ${pkgs.systemd}/bin/loginctl lock-sessions
        sleep 2
        ${pkgs.systemd}/bin/systemctl start suspend.target
      '';
    };
    "lid-open" = {
      event = "button/lid LID open";
      action = ''
        ${pkgs.systemd}/bin/systemctl start iwd.service
      '';
    };
  };
}
