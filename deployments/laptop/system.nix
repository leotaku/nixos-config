# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    # Import plugable configurations
    ../../plugables/networking/laptop.nix
    ../../plugables/perf.nix
    ../../plugables/variables.nix
    # Import custom modules
    ../../modules/backup.nix
  ];

  # Emulate WebAssembly and ARM
  boot.binfmt.emulatedSystems = [ "wasm32-wasi" "aarch64-linux" ];

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
    # Applications
    anki
    blender
    blueman
    calibre
    dfeet
    discord
    emacs-git-custom
    firefox-custom
    gimp
    godot_4
    inkscape
    kitty
    krita
    mpv
    okular
    simple-scan
    pavucontrol
    plasma5Packages.kdeconnect-kde
    sxiv
    syncthing
    virt-manager
    xfce.thunar
    # Utilities
    aria2
    aspell-custom
    davmail
    emv
    fd
    file
    git
    github-cli
    graphicsmagick
    htop
    hyperfine
    isync
    jq
    just
    kakoune
    ledger
    libarchive
    libqalculate
    ncdu
    parallel
    qrencode
    rclone
    ripgrep
    ripgrep-all
    sops
    stow
    tesseract4
    zbar
    # Backend tools
    direnv
    lorri
    tmux
    zoxide
    # Nix utilities
    nixd
    nix-output-monitor
    nix-prefetch-git
    nix-top
    nixfmt
    update-nix-fetchgit
    # GUI utilities
    maim
    xcape
    xclip
    xdo
    xorg.xkbcomp
    xkbset
    # Desktop
    awesome-git
    cbatticon
    picom
    pulseaudio
    redshift
    rofi
    # GUI
    adapta-gtk-theme
    breeze-qt5
    gnome.adwaita-icon-theme
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    lxappearance
    papirus-icon-theme
    qt5ct
    # SDDM support
    qt5.qtgraphicaleffects
    qt5.qtmultimedia
  ];

  fonts.packages = with pkgs; [
    # Fonts
    alegreya
    fira-mono
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

  # Configure interactive shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = false;
    enableGlobalCompInit = false;

    shellAliases = lib.mkForce { };
    setOptions = [ ];

    autosuggestions.enable = false;
    syntaxHighlighting.enable = false;
  };

  # List simple features that you want to enable
  hardware.bluetooth.enable = true;
  powerManagement.enable = true;
  programs.gnupg.agent.enable = true;
  programs.kdeconnect.enable = true;
  services.blueman.enable = true;
  services.hardware.bolt.enable = true;
  services.mullvad-vpn.enable = true;
  services.openssh.enable = true;
  services.postfix.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.postgresql.enable = true;

  # Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplip splix ];
  };
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ hplipWithPlugin ];
  };

  # X11 windowing system
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.wacom.enable = true;

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
        EnableAvatars = true;
        ThemeDir = pkgs.sddm-themes + "/share/sddm/themes";
      };
    };
  };

  # Empty X session to hook into
  services.xserver.displayManager.session = [{
    manage = "window";
    name = "default";
    start = "true";
  }];

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

  # Enable virtualization/container technologies
  services.flatpak.enable = true;
  virtualisation.anbox.enable = false;
  virtualisation.libvirtd.enable = true;

  # Enable Podman without NVIDIA support
  virtualisation.podman = {
    enable = true;
    enableNvidia = false;
  };

  # Enable Docker with NVIDIA support
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
  systemd.services."user@".serviceConfig.Delegate = true;

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
          "**/target"
          ".cache"
          ".debug"
          ".ipfs"
          ".local/share"
          ".var"
          "large"
        ];
      }];
    };
  in {
    jobs = lib.mapAttrs (_: lib.mergeAttrs default) {
      fujitsu = {
        repository = "rest:https://raw.le0.gs:8000";
        timer = [ "*-*-* 11:00" "*-*-* 22:00" ];
      };
      gdata = {
        repository = "rclone:gdata:restic";
        timer = [ "*-*-* 12:00" "*-*-* 23:00" ];
      };
    };
  };

  # Disable NixOS command-not-found functionality
  programs.command-not-found.enable = false;

  # DBus rules for battery management
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="BAT0", \
      ATTR{status}=="Discharging", ATTR{capacity_level}=="Low", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="suspend-then-hibernate.target"
  '';
  systemd.sleep.extraConfig = ''
    SuspendState=mem
    HibernateDelaySec=1h
  '';
}
