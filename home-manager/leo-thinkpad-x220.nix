{ config, lib, pkgs, ... }:

{
  # home-manager bootstrap idiocy
  programs.home-manager.enable = true;
  programs.home-manager.path =
  toString /etc/nixos/nixos-config/sources/links/home-manager;

  # nixpkgs like everywhere else
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ (import ../pkgs/default.nix) ];
  };

  # pluggable configurations
  imports = [ ../plugables/email/home-manager.nix ];

  home.packages = with pkgs; [
    # Text editors
    vscode-with-extensions
    kakoune
    # File Manager
    ranger
    lf
    emv
    fzf
    # Git
    gitAndTools.hub
    gitAndTools.gitRemoteGcrypt
    # Browsers
    #mozilla.firefox-devedition-bin-unwrapped
    w3m
    elinks
    lynx
    # Chat
    weechat
    youtube-dl
    # Games
    #steam
    # Audio
    alsaUtils
    pulsemixer
    audacity
    mpd
    mpc_cli
    ncmpcpp
    cava
    cli-visualizer
    projectm
    # Images
    sxiv
    imagemagick
    pinta
    inkscape
    gcolor3
    # PDF
    zathura
    # Video
    vlc
    ffmpegthumbnailer
    ffmpeg-full
    # Recording
    maim
    simplescreenrecorder
    screenkey
    asciinema
    # Ebook
    calibre
    # Fonts
    font-manager
    # Other
    gcolor3
    lxappearance-gtk3
    # Systems
    tpacpi-bat
    acpi
    efibootmgr
    # Terminal
    xterm
    urxvtWithExtensions
    tmux
    # Performance monitoring
    htop
    gotop
    lshw
    hwinfo
    # Network utils
    nmap-graphical
    netcat-gnu
    speedtest-cli
    bmon
    vnstat
    iptables
    bind
    mtr
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
    libcaca
    # Xorg
    xsel
    xorg.xbacklight
    xorg.xwd
    xorg.xev
    xorg.xmodmap
    xorg.xinit
    xorg.xauth
    xdo
    xdotool
    xvkbd
    xautolock
    wmname
    wmctrl
    xclip
    libnotify
    inotifyTools
    # Utils
    aria
    exa
    fd
    ripgrep
    progress
    chroma
    jq
    tokei
    rlwrap
    bvi
    direnv
    tealdeer
    libqalculate
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
    discount
    python36Packages.pygments
    id3v2
    # Torrent
    transmission-remote-gtk
    transmission-remote-cli
    # WMs
    fvwm
    # Other rice related
    compton-git
    dmenu
    polybar
    dunst
    i3lock-color
    xss-lock
    # Nix
    nix-top
    nix-du
    nix-index
    nix-prefetch-scripts
    # Syncthing
    syncthing-gtk
    syncthing-cli
  ];

  # make fonts work (fonts still don't work)
  fonts.fontconfig.enable = true;

  # user variables
  home.sessionVariables = {
    TERMINAL = "urxvt";
    EDITOR = "kak";
    PAGER = "less";
  };

  # Keyboard
  home.keyboard.layout = "de";
  home.keyboard.variant = "nodeadkeys";

  # Xsession (needs to be split)
  xsession = {
    enable = true;
    windowManager.command = "fvwm";
    initExtra = ''
      # auto-set wallpaper
      feh --bg-fill $HOME/.wallpaper
      # setup locksreen
      xset s 600 300
      xss-lock -- $HOME/.scripts/screenlock &
      # this should be switched to systemd
      compton -b
      polybar mail &
      polybar battery &
      urxvtd &
      mpd
      $HOME/.scripts/xmodmap.sh
      screen -d -m -S NcmpcppContainer "$HOME/.config/ncmpcpp/spawn-script"
    '';
  };

  # Redshift
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };

  # GTK settings
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Darker";
    iconTheme.package = pkgs.gnome3.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    gtk2 = {
      extraConfig = ''
        gtk-toolbar-style=GTK_TOOLBAR_ICONS
        gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
      '';
      # gtk-key-theme-name = Emacs
    };
    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
        # gtk-key-theme-name = "Emacs";
      };
    };
  };

  # Git settings
  programs.git = {
    enable = true;
    userName = "LeOtaku";
    userEmail = "leo.gaskin@brg-feldkirchen.at";
  };

  # Syncthing client
  services.syncthing.enable = true;
}
