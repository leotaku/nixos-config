{ config, pkgs, ... }:

{
  ## Home manager configuration for this account
  programs.home-manager.enable = true;
  
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ (import ../pkgs/default.nix) ];
  };
  
  home.packages = with pkgs; [
    # Text editors
    leovim
    instant-markdown-d
    vscode-with-extensions
    # File Manager
    ranger
    vifm
    fzf
    fzy
    gnome3.nautilus
    # Office
    ###libreoffice-fresh
    scim
    libqalculate
    # Version control
    #gitFull
    gitAndTools.hub
    gitAndTools.gitRemoteGcrypt
    gource
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
    # TODO: this
    ###vmail
    thunderbird
    # Chat
    weechat
    irssi
    discord
    # Other Web
    rtv
    canto-curses
    youtube-dl
    # Games
    steam
    # Audio
    alsaUtils
    pulsemixer
    ncpamixer
    audacity
    mpd
    mpc_cli
    ncmpcpp
    cava
    cli-visualizer
    projectm   freeciv_gtk
    # Images
    feh
    meh
    sxiv
    imagemagick
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
    kdeApplications.kdenlive
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
    python36Packages.glances
    htop
    atop
    gotop
    # Network utils
    #wireshark-gtk
    nmap-graphical
    netcat-gnu
    speedtest-cli
    bmon
    vnstat
    iptables
    bind
    #mtr
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
    catimg
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
    tealdeer
    bro
    most
    # ++
    rlwrap
    reptyr
    autojump
    hyperfine
    thefuck
    # Filesystems
    bashmount
    usbutils
    mtpfs
    libmtp
    # Archiving
    p7zip
    libarchive
    # Documents + Other
    pandoc
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
    torrench
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
    sxhkd
    compton-git
    dmenu
    polybar
    dzen2
    #dunst
    i3lock-color
    eventd
    # Programming
    gocode
    gotags
    delve
    chez
    universal-ctags
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
    windowManager.command = "2bwm";
    initExtra = "
    feh --bg-fill ~/Images/white.png
    mpd
    compton -b
    eventd &
    polybar float &
    urxvtd &
    xautolock -locker ~/Scripts/screenlock &
    $HOME/Scripts/update_workspaces.sh &
    $HOME/Scripts/waitlock &
    ";
  };
  
  gtk = {
    enable = true;
    theme.package = pkgs.adapta-gtk-theme;
    theme.name = "Adapta-Eta";
    iconTheme.package = pkgs.paper-icon-theme;
    iconTheme.name = "Paper";
  };
    
  programs.git = {
    enable = true;
    userName  = "LeOtaku";
    userEmail = "leo.gaskin@brg-feldkirchen.at";
  };
}
