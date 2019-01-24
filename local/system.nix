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
    ../plugables/backup/restic-all.nix
    # Enable throwaway account
    ../plugables/throwaway/default.nix
    # Test stuff
    #../containers/test.nix
  ];

  hardware.opengl.enable = true;
  
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "wlp3s0";
  
  nix.useSandbox = true;

  nixpkgs.overlays = [ (import ../pkgs) ];

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
    unmanaged = [ "interface-name:ve-*" ];
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
    # Needed
    gitFull
    gitAndTools.gitRemoteGcrypt
    # Utils
    moreutils
    psmisc
    file
    tree
    stow
    ncdu
    cron
    wget
    curl
    aria
    autojump
    # Terminal toys
    figlet
    toilet
    fortune
    cowsay
    lolcat
    neofetch
    # Terminal basics
    ranger
    nvi
    neovim
    micro
    kakoune
    # Monitors
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
    #zathura
    mplayer
    #vlc
    ffmpeg-full
    #pandoc
    # Archives
    p7zip
    # Version control
    mercurial
    #darcs
    bazaar
    cvs
    # Shells
    bash
    zsh
    fish
    dash
    elvish
    #xonsh
  ];
  
  #TODO: fix fc cache in home-manager
  fonts.fonts = with pkgs; [
    gohufont
    terminus_font
    unifont
    siji
    google-fonts
    go-font
    lmmath
    tewi-font
    dina-font
    fira-code
    fira-mono
    roboto
  ];
  
  environment.variables = {
    EDITOR = [ "vim" ];
    TERMINAL = [ "urxvt" ];
    SHELL = [ "zsh" ];
    PAGER = [ "less" ];
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh-custom}/share/oh-my-zsh" ];
    AUTOJUMP = [ "${pkgs.autojump}/share/zsh/" ];
  };
  
  # List programs that need nix init
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # List simple services that you want to enable:
  services.upower.enable = true;
  powerManagement.enable = true;
  services.openssh.enable = true;
  services.cron.enable = false;
  services.netdata.enable = true;

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplip gutenprint gutenprintBin splix ];

  # Needed for home-manager to work
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  # X11 windowing system.
  services.xserver.enable = true; 
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "test";
    extraConfig = ''
      [Autologin]
      Relogin=false
      Session=
      User=

      [General]
      InputMethod=
      
      [Theme]
      ThemeDir=${pkgs.sddm_theme}/share/sddm/themes
    '';
  };

  # Sound
  hardware.pulseaudio.enable = true;

  # Steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;

  # Firewall configuration
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable Virtuaisation
  virtualisation.virtualbox.host = { 
    enable = false;
    #enableHardening = false; 
  };
  nixpkgs.config.virtualbox.enableExtensionPack = false;

  virtualisation.docker.enable = true;

  # Add wireshark permissions
  programs.wireshark = { 
    enable = true;
    package = pkgs.wireshark-gtk;
  };

  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = "root";
  };

  # services.grafana = {
  #   enable = true;
  #   port     = 3000;
  #   domain   = "localhost";
  #   protocol = "http";
  #   dataDir  = "/var/lib/grafana";
  #   auth.anonymous.enable = true;
  # };

  # services.graphite.api = {
  #   enable = true;
  #   port = 3030;
  # };

# services.prometheus = {
#     enable = true;
#     configText = ''
# scrape_configs:
#   # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
#   - job_name: 'prometheus'
# 
#     # metrics_path defaults to '/metrics'
#     # scheme defaults to 'http'.
# 
#     static_configs:
#       - targets: ['localhost:9090']
# 
#   - job_name: 'netdata'
# 
#     metrics_path: /api/v1/allmetrics
#     params:
#       format: [ prometheus ]
# 
#     static_configs:
#       - targets: ['localhost:19999']
# '';
#   };
  
  # Fix broken lid-suspend
  services.logind.lidSwitch = "ignore";
  services.acpid.enable = true;
  services.acpid.lidEventCommands = ''
    LID_STATE=/proc/acpi/button/lid/LID/state 
    if [[ $(${pkgs.gawk}/bin/awk '{print $2}' $LID_STATE) == 'closed' ]]; then
      ${pkgs.systemd}/bin/loginctl lock-sessions
      sleep 2
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
}
