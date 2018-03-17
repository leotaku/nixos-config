# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{ 
  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/nixpkgs"
    "nixos=/etc/nixos/nixos-config/nixpkgs/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    #"nixpkgs-overlays=/etc/nixos/nixos-config/pkgs"
  ];

  nixpkgs.overlays = [ (import ../pkgs) ];
  programs.man.enable = false;
  services.nixosManual.enable = false;

  networking.hostName = "nixos-rpi"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
      addresses = true;
    };
  };

  #services.dhcpd4.enable = true;

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
    ## Nixos
    nixUnstable
    ## Terminal Apps
    vim_configurable
    ranger
    htop
    atop
    bmon
    python3Packages.glances
    vnstat
    neofetch
    ## Graphical Apps
    ## Utilities
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
    ## Other
    zsh
    oh-my-zsh
    zsh-completions
    # Vim
    ## Languages
    #R
    # Python
    #python3Full
    #python36Packages.pip
    #python36Packages.virtualenv
    #python36Packages.pylint
  ];

  fonts.fonts = with pkgs; [
  ];
  
  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    EDITOR = [ "vim" ];
    TERMINAL = [ "urxvt" ];
    RANGER_LOAD_DEFAULT_RC = [ "FALSE" ];
  };

  # Some programs need SUID wrappeas, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

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

  # Enable ZNC IRC bouncer
  services.znc = {
    enable = true;
    openFirewall = true;
    confOptions = {
      port = 14990;
      nick = "leotaku";
      passBlock = ''
      <Pass password>
        Method = sha256
        Hash = 4d1f02701e27fee1405d52527bc93f9ad8e233a0946f1bc86ea540edeb176af7
        Salt = 9vpyWS6!(5wkCR3uv:_5
       </Pass>
      '';
      networks.freenode = {
        port = 6697; 
        server = "chat.freenode.net"; 
        useSSL = true;
        channels = [ "nixos" ];
        modules = [ "simple_away" ];
      };
      extraZncConf = ''
        MaxBufferSize=10000
      '';
    };
  };

  # Enable Transmission torrent service
  services.transmission = { 
    enable = false;
    port = 9091;
    settings = {
      utp-enabled = false;
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      peer-port = 10528;
      #proxy-enabled = true;
      #proxy = "10.8.0.1";
      #proxy-port = 1080;
      #proxy-type = 2;
    };
  };

  systemd.services.transmission = {
    wantedBy = lib.mkOverride 50 [];
    #environment.systemPackages = lib.mkOverride 50 [];
  };

  # Add OpenVPN servers 
  services.openvpn.servers = {
    #mullvadAT = { config = '' config /home/leo/openvpn/mullvad_at.conf ''; };
  };
}
