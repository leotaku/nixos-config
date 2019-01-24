{ config, lib, pkgs, ... }:

{
  ## Home manager configuration for this account
  programs.home-manager.enable = true;
  programs.home-manager.path = toString /etc/nixos/nixos-config/sources/links/libs/home-manager;
  
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ (import ../pkgs/default.nix) ];
  };

  accounts.email.accounts.leo = {
    address = "leo.gaskin@brg-feldkirchen.at";
    flavor = "plain";
    primary = true;
  };
  
  home.packages = with pkgs; [
    # Text editors
    #leovim
    #vscode-with-extensions
    # File Manager
    ranger
    lf
    vifm
    clex
    fzf
    fzy
    gnome3.nautilus
    # Office
    #libreoffice-fresh
    #calligra
    scim
    libqalculate
    # Version control
    #gitFull
    gitAndTools.hub
    gitAndTools.gitRemoteGcrypt
    gource
    # Browsers
    firefox
    #vivaldi
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
    irssi
    discord
    # Other Web
    rtv
    ddgr
    canto-curses
    youtube-dl
    # Games
    #steam
    # Audio
    alsaUtils
    pulsemixer
    ncpamixer
    pavucontrol
    audacity
    mpd
    mpc_cli
    ncmpcpp
    cava
    cli-visualizer
    projectm
    freeciv_gtk
    # Images
    feh
    meh
    sxiv
    imagemagick
    pinta
    krita
    gimp
    inkscape
    gcolor3
    # PDF
    zathura
    evince
    # Video
    vlc
    mplayer
    mpv
    ffmpegthumbnailer
    ffmpeg-full
    #kdeApplications.kdenlive
    # Recording
    maim
    slop
    simplescreenrecorder
    screenkey
    asciinema
    # Ebook
    calibre
    # Fonts
    gnome3.gucharmap
    font-manager
    fontmatrix
    # Other
    gcolor3
    lxappearance-gtk3
    # Systems
    tpacpi-bat
    acpi
    efibootmgr
    # Emulation
    wine
    # Terminal
    xterm
    urxvtWithExtensions
    tmux
    # Performance monitoring
    #python36Packages.glances
    htop
    atop
    gotop
    lshw
    hwinfo
    # Network utils
    wireshark-gtk
    nmap-graphical
    netcat-gnu
    speedtest-cli
    bmon
    vnstat
    iptables
    bind
    mtr
    liboping
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
    tty-clock
    terminal-parrot
    #catimg
    libcaca
    # Xorg
    xsel
    xorg.xbacklight
    xorg.xev
    xdo
    xdotool
    xvkbd
    xautolock
    wmname
    wmctrl
    xclip
    xorg.xinit
    xorg.xauth
    libnotify
    inotifyTools
    # Base +
    aria
    exa
    fd
    ripgrep
    progress
    chroma
    most
    loc
    rlwrap
    bvi
    # ++
    reptyr
    fasd
    hyperfine
    thefuck
    bro
    tealdeer
    # Filesystems
    bashmount
    usbutils
    mtpfs
    libmtp
    # Archiving
    p7zip
    libarchive
    # Documents + Other
    #haskellPackages.pandoc
    #haskellPackages.pandoc-citeproc
    asciidoctor
    graphviz
    # Misc Filetype
    exiftool
    poppler_utils
    mediainfo
    atool
    highlight
    ###unoconv
    discount
    python36Packages.pygments
    id3v2
    # Torrent
    #torrench
    transmission-remote-gtk
    transmission-remote-cli
    # WMs
    _2bwm
    fvwm
    awesome
    openbox
    wmutils-core
    wmutils-opt
    # Other rice related
    xorg.xwd
    sxhkd
    compton-git
    dmenu
    networkmanager_dmenu
    polybar
    dzen2
    dunst
    #eventd
    i3lock-color
    xss-lock
    #eventd
    # Programming
    gocode
    gotags
    delve
    chez
    #universal-ctags
    # Webdev
    hugo
    # Fonts
    # TODO: sowehow fix font colls
    # TODO: fix fc search path
    #siji
    #font-awesome-ttf
    #google-fonts
    #noto-fonts
    #noto-fonts-emoji
    #lmmath
    ##nerdfonts
    #gohufont
    #terminus_font
    ##tewi-font
    #dina-font
    #fira-code
    #fira-mono
    #roboto
    #montserrat
    # Nix
    nix-top
    nix-du
    nix-index
    nix-prefetch-scripts
  ];
  
  home.sessionVariables = {
    TERMINAL = "urxvt";
    EDITOR = "vim";
    PAGER = "less";
    RANGER_LOAD_DEFAULT_RC = "FALSE";
  };
  
  home.keyboard.layout = "de";
  home.keyboard.variant = "nodeadkeys";
  #home.keyboard.options = "eurosign:e";

  #fonts.fontconfig.enableProfileFonts = true;
  
  xsession = {
    enable = true;
    #profileExtra = "";
    windowManager.command = "fvwm";
    initExtra = ''
    feh --bg-fill $HOME/.wallpaper
    mpd
    compton -b
    eventd &
    polybar small &
    urxvtd &
    xset s 600 300
    xss-lock -- $HOME/Scripts/screenlock &
    screen -d -m -S NcmpcppContainer "$HOME/.config/ncmpcpp/spawn-script"
    '';
  };
  
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Darker";
    iconTheme.package = pkgs.gnome3.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    # theme.package = pkgs.adapta-gtk-theme;
    # theme.name = "Adapta-Eta";
    # iconTheme.package = pkgs.paper-icon-theme;
    # iconTheme.name = "Paper";
    gtk2 = {
      extraConfig = ''
        gtk-toolbar-style=GTK_TOOLBAR_ICONS
        gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
      '';
      };
    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      };
      extraCss = ''
      .termite {
        padding: 15px;
      }
      '';
    };
  };
    
  programs.git = {
    enable = true;
    userName  = "LeOtaku";
    userEmail = "leo.gaskin@brg-feldkirchen.at";
  };

  programs.emacs.enable = false;
}
