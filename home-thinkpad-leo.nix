# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/nixos-module.tar.gz}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Terminal Apps
    vim_configurable
    htop
    figlet
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

  # Define an user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.leo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  home-manager.users.leo = {
    home.file."TEST".text = "foo";
    home.packages = [ pkgs.hello ];
    programs.git = {
      enable = true;
      userName  = "LeOtaku";
      userEmail = "leo.gaskin@brg-feldkirchen.at";
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
