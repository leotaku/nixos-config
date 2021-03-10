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
    ../../plugables/zsa.nix
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
    arandr
    autorandr
    glxinfo
    powertop
    srandrd
    tpacpi-bat
    virt-manager
    # SDDM
    qt5.qtgraphicaleffects
    qt5.qtmultimedia
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
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAliases = lib.mkForce { };
  };

  # List simple features that you want to enable
  hardware.bluetooth.enable = true;
  powerManagement.enable = true;
  programs.gnupg.agent.enable = true;
  services.autorandr.enable = false;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.hardware.bolt.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;

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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # SDDM display manager
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "haze";
    settings = {
      Theme = {
        ThemeDir = pkgs.sddm-themes + "/share/sddm/themes";
      };
    };
  };

  # PipeWire for sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Steam support
  programs.steam.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;

  # Sysctl settings for Steam
  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };

  # Enable virtualization/container technologies
  services.flatpak.enable = false;
  virtualisation.anbox.enable = false;
  virtualisation.libvirtd.enable = true;

  # Enable Podman with NVIDIA support
  virtualisation.podman = {
    enable = true;
    enableNvidia = false;
    dockerCompat = true;
  };

  # Add Wireshark permissions
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Backup important directories
  backup = let
    default = {
      enable = true;
      user = "leo";
      passwordFile = builtins.toString /var/keys/restic-passwd;
      paths = [{
        path = "/home/leo";
        exclude = [
          "**/*.a"
          "**/*.o"
          "**/*.rlib"
          "**/*.rmeta"
          "**/*.so"
          "**/target"
          ".cabal"
          ".cache"
          ".cargo"
          ".ghc"
          ".ipfs"
          ".local/share"
          ".maildir/.notmuch"
          ".multimc"
          ".npm"
          ".rustup"
          ".stack"
          ".technic"
          ".var/app"
          "large"
        ];
      }];
    };
  in {
    jobs = map (lib.mergeAttrs default) [
      {
        repository = "rest:http://raw.le0.gs:8000";
        timer = [ "*-*-* 11:00" "*-*-* 22:00" ];
      }
      {
        repository = "rclone:gdata:restic";
        timer = [ "*-*-* 12:00" ];
      }
    ];
  };

  # Run LocateDB every hour
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };

  # Disable NixOS command-not-found functionality
  programs.command-not-found.enable = false;

  # Upower for battery management
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };
}
