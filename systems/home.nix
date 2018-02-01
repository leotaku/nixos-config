# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.memtest86.enable = true;

  #override default nixos stuff
  boot.loader.grub.splashImage = null;
  boot.loader.grub.gfxmodeBios = "1366x768";
  boot.loader.timeout = -1;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Terminal Apps
    efibootmgr
    vim_configurable
    htop
    figlet
    fortune
    cowsay
    lolcat
    cmatrix
    pulsemixer
    cava
    cli-visualizer
    ncmpcpp
    weechat
    canto-curses
    pamix
    ranger
    # Graphical Apps
    xterm
    rxvt_unicode
    urxvt_perls 
    firefox
    vscode
    steam
    feh
    # Utilities
    wget
    git
    xclip
    nixUnstable
    dmenu
    ncdu
    w3m
    bashmount
    psmisc
    # Other
    herbstluftwm
    compton
    zsh
    oh-my-zsh
    polybar
    mpd
    mpc_cli
  ];

  environment.variables = {
    TERMINAL = [ "urxvt" ];
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    EDITOR = [ "vim" ];
  };

  # Some programs need SUID wrappeas, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  
  # Enable Zsh to avoid bugs
  programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";
  # For Steam
  hardware.opengl.driSupport32Bit = true;
  
  # Enable compton
  services.compton.enable = true;
 
  # Enable PulseAudio
  hardware.pulseaudio.enable = true;
  # For Steam
  hardware.pulseaudio.support32Bit = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the DE/WM + DM 
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.herbstluftwm.enable = true;

}
