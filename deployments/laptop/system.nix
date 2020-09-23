# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    # Import plugable configurations
    ../../plugables/netdata.nix
    ../../plugables/networking/laptop.nix
    ../../plugables/variables.nix
    ../../plugables/xkeyboard/module.nix
    # Import package collections
    ../../plugables/packages/gui.nix
    ../../plugables/packages/large.nix
    # Import custom modules
    ../../modules/backup.nix
  ];

  # Enable unstable features
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };

  # Hostname
  networking.hostName = "nixos-laptop";

  # Nixpkgs settings
  nixpkgs.overlays = [ (import ../../pkgs) ];
  nixpkgs.config.allowUnfree = true;

  # Set time zone
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  i18n.defaultLocale = "en_US.UTF-8";

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

  # List programs that need nix wrappers
  programs.adb.enable = true;
  programs.dconf.enable = true;
  programs.gnome-disks.enable = true;
  programs.light.enable = true;
  programs.slock.enable = true;

  # Configure default shell
  programs.fish.enable = true;

  # List simple features that you want to enable
  hardware.bluetooth.enable = true;
  powerManagement.enable = true;
  services.autorandr.enable = false;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.hardware.bolt.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  # Redshift and Geoclue2
  location.provider = "geoclue2";
  services.redshift.enable = true;
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

  # DBUS user session
  services.dbus.socketActivated = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  # X11 windowing system
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.wacom.enable = true;

  # URxvt daemon
  services.urxvtd = {
    enable = true;
    package = pkgs.rxvt-unicode;
  };

  # Basic XDG support
  xdg.portal = {
    enable = true;
    gtkUsePortal = false;
  };

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
  hardware.pulseaudio.systemWide = true;

  # Steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;

  # Enable virtualization/container technologies
  virtualisation.libvirtd.enable = true;
  services.flatpak.enable = false;
  virtualisation.docker.enable = false;
  virtualisation.anbox.enable = false;

  # Add Wireshark permissions
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Backup important directories
  backup = {
    enable = true;
    timer = [ "*-*-* 11:00" "*-*-* 22:00" ];
    repository = "rest:http://raw.le0.gs:8000";
    passwordFile = builtins.toString ../../private/restic-pw;
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

  # Run LocateDB every hour
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };

  # Disable NixOS command-not-found functionality
  programs.command-not-found = {
    enable = false;
  };
}
