# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{ 
  imports = [
    ../plugables/avahi/default.nix
    ../plugables/znc/default.nix
  ];

  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/nixpkgs"
    "nixos=/etc/nixos/nixos-config/nixpkgs/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    #"nixpkgs-overlays=/etc/nixos/nixos-config/pkgs"
  ];

  nixpkgs.overlays = [ (import ../pkgs) ];
  documentation.man.enable = false;
  services.nixosManual.enable = false;

  networking.hostName = "nixos-rpi"; # Define your hostname.
  networking.networkmanager.enable = true;
  #networking.interfaces."eth0" = {
  #  ip4 = [ { address = "192.168.1.251"; prefixLength = 24; } ];
  #};
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    pkgs.broadcom-rpi3-extra
  ];

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
    vim
    ranger
    htop
    atop
    bmon
    python3Packages.glances
    vnstat
    neofetch
    # Graphical Apps
    # Utilities
    tree
    wget
    git
    ncdu
    w3m 
    bashmount
    efibootmgr
    tmux
    libarchive
    dash
    # Other
    zsh
  ];

  fonts.fonts = with pkgs; [
  ];
  
  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    EDITOR = [ "vim" ];
    TERMINAL = [ "urxvt" ];
  };

  # Some programs need SUID wrappeas, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh.enable = true;

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  #services.printing.enable = true;
  #services.printing.drivers = with pkgs; [ hplip gutenprint gutenprintBin splix ];

}
