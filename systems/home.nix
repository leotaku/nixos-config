# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{ 
  imports = [
    # Import plugable configurations
    ../plugables/avahi/default.nix
    ../plugables/openvpn/serverlist.nix
    ../plugables/transmission/default.nix
  ];

  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/nixpkgs"
    "nixos=/etc/nixos/nixos-config/nixpkgs/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    "home-manager=/etc/nixos/nixos-config/modules/home-manager"
  ];

  nixpkgs.overlays = [ (import ../pkgs) ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.memtest86.enable = true;

  # Override default nixos stuff
  boot.loader.grub.splashImage = null;
  boot.loader.grub.gfxmodeBios = "1366x768";
  boot.loader.timeout = 10;
  boot.plymouth.enable = true;

  # less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  boot.earlyVconsoleSetup = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    packages = with pkgs; [ networkmanager_openvpn ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";
  
  nixpkgs.config.allowUnfree = true;
  # TODO: Move this to separate home manager file
  environment.systemPackages = with pkgs; [
    # Utils
    moreutils
    file
    tree
    stow
    ncdu
    chron
    wget
    curl
    aria
    # Terminal toys
    figlet
    toilet
    fortune
    cowsay
    lolcat
    neofetch
    # Terminal basics
    ranger
    vim_configurable
    neovim
    micro
    kakoune
    # Monitors
    top
    htop
    atop
    bmon
    # Browsers
    firefox
    lynx
    elinks
    w3m
    # Internet
    weechat
    # Terminal
    xterm
    rxvt_unicode
    tmux
    screen
    # Files
    sxiv
    imagemagick
    zathura
    mplayer
    vlc
    ffmpeg-full
    pandoc
    # Archives
    p7zip
    # Version control
    gitFull
    mercurial
    darcs
    bazaar
    cvs
    # Shells
    bash
    zsh
    fish
    dash
    elvish
    xonsh
  ];
  
  #fonts.fontconfig.antialias = false;
  #fonts.fontconfig.subpixel.lcdfilter = "none";
  # TODO: move this
  fonts.fonts = with pkgs; [
    siji
    font-awesome-ttf
    google-fonts
    noto-fonts
    noto-fonts-emoji
    lmmath
    #nerdfonts
    gohufont
    terminus_font
    tewi-font
    dina-font
    fira-code
    fira-mono
    roboto
    montserrat
  ];
  
  environment.variables = {
    EDITOR = [ "vim" ];
    TERMINAL = [ "urxvt" ];
    # TODO: find better solution for this
    NIXOS_DESCRIPTIVE_NAME = [ "home" ];
  };
  
  # TODO: Refactor this to be more flexible
  environment.shellAliases = {
    nix-env = "nix-env -f /etc/nixos/nixos-config/files/fake-channel.nix";
  };

  # List services that you want to enable:
  
  # Enable upower
  services.upower.enable = true;

  # Enable powerManagement
  powerManagement.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable Cron
  services.cron.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplip gutenprint gutenprintBin splix ];

  # Enable the X11 windowing system.
  services.xserver.enable = true; 
 
  # Enable the DE/WM + DM 
  services.xserver.displayManager.lightdm = { 
    enable = true;
    #background = "${pkgs.nixos-artwork.wallpapers.stripes-logo}/share/artwork/gnome/nix-wallpaper-stripes-logo.png";
    background = "${pkgs.adapta-backgrounds}/share/backgrounds/adapta/tealized.jpg";
    greeters.gtk = {
      theme.package = pkgs.adapta-gtk-theme;
      theme.name = "Adapta-Eta";
      iconTheme.package = pkgs.paper-icon-theme;
      iconTheme.name = "Paper";
    };
  };

  # Enable PulseAudio
  hardware.pulseaudio.enable = true;
  # For Steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  
  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable Virtualbox
  virtualisation.virtualbox.host = { 
    enable = true;
    #enableHardening = false; 
  };

  nixpkgs.config.virtualbox.enableExtensionPack = false;

  # Add wireshark permissions
  programs.wireshark = { 
    enable = true;
    package = pkgs.wireshark-gtk;
  };

  services.logind.lidSwitch = "ignore";
  
  services.acpid.enable = true;
}
