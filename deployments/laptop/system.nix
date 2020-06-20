# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    # Import plugable configurations
    ../../plugables/networking/laptop.nix
    ../../plugables/variables.nix
    ../../plugables/xkeyboard/module.nix
    # Import package collections
    ../../plugables/packages/large.nix
    # Import custom modules
    ../../modules/backup.nix
  ];

  # Nixpkgs settings
  nixpkgs.overlays = [ (import ../../pkgs) ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.virtualbox.enableExtensionPack = false;

  # Booting
  boot.loader.timeout = 10;
  boot.plymouth.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

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

  environment.systemPackages = with pkgs; [
    # Laptop utilities
    acpi
    glxinfo
    powertop
    tpacpi-bat
    virt-manager
  ];

  # Global environment
  environment.variables = with pkgs; {
    EDITOR = kakoune + "/bin/kak";
    TERMINAL = xterm + "/bin/xterm";
    PAGER = less + "/bin/less";
  };
  environment.homeBinInPath = true;

  # Sysctl settings
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };

  # List programs that need nix wrappers
  programs.adb.enable = true;
  programs.dconf.enable = true;
  programs.gnome-disks.enable = true;
  programs.light.enable = true;
  programs.slock.enable = true;

  # Configure default shell
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  programs.zsh.promptInit = '''';

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
  xdg.portal.gtkUsePortal = false;

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
  hardware.pulseaudio.configFile = ../../files/pulseaudio.pa;

  # Steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;

  # Firewall configuration
  networking.firewall.enable = false;

  # Enable virtuaisation/container technologies
  virtualisation.libvirtd.enable = true;
  services.flatpak.enable = false;
  virtualisation.docker.enable = false;
  virtualisation.anbox.enable = false;

  # Add wireshark permissions
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Backup important directories
  backup = {
    enable = true;
    timer = [ "*-*-* 11:00" "*-*-* 22:00" ];
    repository = "rest:http://raw.le0.gs:8000";
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

  # FIXME: NixOS command-not-found functionality
  programs.command-not-found = {
    enable = false;
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
        ${pkgs.systemd}/bin/systemctl suspend
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
