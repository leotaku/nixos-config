# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{ 
  imports = [
    # Enable working Avahi
    ../plugables/avahi/default.nix
    # Add all known OpenVPN servers
    ../plugables/openvpn/serverlist.nix
    # Enable transmission service
    ../plugables/transmission/default.nix
  ];

  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/nixpkgs"
    "nixos=/etc/nixos/nixos-config/nixpkgs/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    #"nixpkgs-overlays=/etc/nixos/nixos-config/pkgs"
  ];

  nixpkgs.overlays = [ (import ../pkgs) ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.memtest86.enable = true;

  # Override default nixos stuff
  boot.loader.grub.splashImage = null;
  boot.loader.grub.gfxmodeBios = "1366x768";
  boot.loader.timeout = -1;
  boot.plymouth.enable = true;

  # less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  #boot.earlyVconsoleSetup = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    packages = with pkgs; [ networkmanager_openvpn ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
    # Nix
    nixUnstable
    nix-repl
    nox
    nix-index
    python2nix 
    nodePackages.node2nix
    bundix
    nix-prefetch-scripts
    # Terminal toys
    figlet
    toilet
    fortune
    cowsay
    lolcat
    cmatrix
    pipes
    neofetch
    screenfetch
    sl
    bashSnippets
    tty-clock
    # File managers
    ranger
    vifm
    xfce.thunar
    gnome3.nautilus
    dolphin
    #fzf
    # Text editors + plugins
    vim_configurable
    instant-markdown-d
    micro
    # IDEs
    vscode-with-extensions
    #jetbrains.pycharm-community
    #python36Packages.notebook
    #currently only works when loaded with python env
    # Office
    libreoffice-fresh
    scim
    libqalculate
    # Performance monitoring
    python36Packages.glances
    htop
    atop
    gtop
    # Network utils
    #wireshark-gtk
    nmap-graphical
    netcat-gnu
    speedtest-cli
    bmon
    vnstat
    iptables
    # Audio
    alsaUtils
    pulsemixer
    pamix
    # Recording
    audacity
    # Music
    mpd
    mpc_cli
    ncmpcpp
    cava
    cli-visualizer
    projectm
    # Browsers
    firefox
    vivaldi
    qutebrowser
    surf
    w3m
    elinks
    lynx
    # Mail
    neomutt
    offlineimap
    notmuch
    dialog
    thunderbird
    # Chat
    weechat
    discord
    # Other Internet
    rtv
    canto-curses
    youtube-dl
    # Life  
    taskwarrior
    # Terminals
    xterm
    rxvt_unicode
    urxvt_perls 
    alacritty
    termite
    kitty
    st
    mlterm
    # Terminal multiplexers
    tmux
    screen
    # Games
    steam
    # Images
    feh
    sxiv
    imagemagick
    #krita
    gimp
    # PDF
    zathura
    evince
    # Video
    vlc
    mplayer
    mpv
    gnome-mpv
    ffmpegthumbnailer
    ffmpeg-full
    # Font management
    gnome3.gucharmap
    font-manager
    fontmatrix
    # Xorg
    xorg.xbacklight
    xorg.xev
    xdo
    xdotool
    xvkbd
    wmname
    xclip
    xorg.xinit
    xorg.xauth
    libnotify
    inotifyTools
    # Misc graphical apps
    gcolor3
    # Systems
    tpacpi-bat
    acpi
    efibootmgr
    # Version control
    gitFull
    gitAndTools.git-hub
    gitAndTools.gitRemoteGcrypt
    mercurial
    darcs
    # Security
    gnupg
    gpa
    tomb
    pass
    openssh
    libressl
    # Base
    coreutils
    binutils-unwrapped
    utillinux
    utillinuxCurses
    tree
    wget
    curl
    stow
    ncdu
    psmisc
    bc
    # Screenshots + screen recording
    scrot
    maim
    slop
    simplescreenrecorder
    screenkey
    asciinema
    # Shells
    bash
    zsh
    oh-my-zsh
    zsh-completions
    #athame-zsh
    dash
    # Filesystems
    bashmount
    usbutils
    mtpfs
    libmtp
    # Archiving
    p7zip
    libarchive
    # Misc Filetype
    pandoc
    exiftool
    poppler_utils
    mediainfo
    atool
    highlight
    unoconv
    discount
    gcolor2
    python36Packages.pygments
    id3v2
    # Torrent
    torrench
    transmission-remote-gtk
    transmission-remote-cli
    deluge
    qbittorrent
    # WMs
    windowchef
    herbstluftwm
    wmutils-core
    wmutils-opt
    #howm
    #cottage
    # Other rice related
    lxappearance-gtk3
    sxhkd
    compton-git
    #interrobang
    dmenu
    polybar
    dzen2
    dunst
  ];

  fonts.fonts = with pkgs; [
    siji
    font-awesome-ttf
    google-fonts
    lmmath
    #nerdfonts
    gohufont
    terminus_font
    tewi-font
    dina-font
    fira-code
    fira-mono
  ];
  
  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    EDITOR = [ "vim" ];
    TERMINAL = [ "urxvt" ];
    RANGER_LOAD_DEFAULT_RC = [ "FALSE" ];
  };

  environment.shellAliases = {
    nix-env = "nix-env -f /etc/nixos/nixos-config/files/fake-channel.nix";
  };

  # Some programs need SUID wrappeas, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  
  # Test Test
  #programs.ibus.enable = true;

  # Enable upower
  services.upower.enable = true;

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

  # Enable clipboard manager
  services.gnome3.gpaste.enable = false;

  # Enable Virtualbox
  virtualisation.virtualbox.host = { 
    enable = true;
    #enableHardening = false; 
  };

  nixpkgs.config.virtualbox.enableExtensionPack = false;

  # Enable Deluge torrent server
  services.deluge.enable = false;

  # Add wireshark permissions
  programs.wireshark = { 
    enable = true;
    package = pkgs.wireshark-gtk;
  };

  services.logind.lidSwitch = "ignore";
  
  services.acpid.enable = true;
  services.acpid.lidEventCommands = ''
    LID_STATE=/proc/acpi/button/lid/LID/state
    if [ $(${pkgs.gawk}/bin/awk '{print $2}' $LID_STATE) = 'closed' ]; then
      if `${pkgs.coreutils}/bin/cat /home/leo/nosuspend`; then
        ${pkgs.xorg.xset}/bin/xset dpms force off
      else
        ${pkgs.systemd}/bin/systemctl suspend
      fi
    fi
  '';
}
