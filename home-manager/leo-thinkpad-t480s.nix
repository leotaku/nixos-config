{ config, lib, pkgs, options, ... }:

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

  # modules and pluggable configurations
  imports = [
    #../plugables/email/home-manager.nix
    ../modules/qt5ct.nix
  ];

  home.packages = with pkgs; [
    # Control
    connman-gtk
    pulsemixer
    # Text editors
    kakoune
    vscode-with-extensions
    # File Manager
    emv
    fzf
    # Chat
    weechat
    # Images
    imagemagick
    sxiv
    pinta
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
    # Terminal
    kitty
    # Information
    htop
    gotop
    lshw
    hwinfo
    # Network utils
    netcat-gnu
    speedtest-cli
    # Terminal toys
    # Xorg
    xsel
    xorg.xmodmap
    xdo
    xdotool
    wmname
    wmctrl
    libnotify
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
    gitAndTools.hub
    tealdeer
    libqalculate
    # Filesystems
    bashmount
    usbutils
    mtpfs
    # Archiving
    p7zip
    libarchive
    # Documents + Other
    pandoc
    graphviz
    # Misc Filetype
    exiftool
    poppler_utils
    mediainfo
    atool
    discount
    id3v2
    # Torrent
    transmission-remote-gtk
    transmission-remote-cli
    # Syncthing
    syncthing-gtk
    syncthing-cli
  ] ++ [
    fira-code
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

  # Redshift
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  

  # X settings
  xsession = {
    enable = true;
    pointerCursor = {
     name = "Adwaita";
     package = pkgs.gnome3.adwaita-icon-theme;
     size = 32;
    };

    # AwesomeWM
    windowManager.awesome = {
      enable = true;
    };
  };

  # Xresources settings
  xresources.properties = {
    "Xft.dpi" = 144;
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = 1;
    "Emacs*toolBar" = 0;
    "Emacs*menuBar" = 0;
    "Emacs*scrollBar" = 0;
  };

  # QT settings
  qt5ct = {
    enable = true;
    impure = true;
    theme.package = pkgs.breeze-icons;
    iconTheme.package = pkgs.breeze-qt5;
    fonts = {
      general.package = pkgs.fira;
      fixed.package = pkgs.fira-mono;
    };
  };
  
  # GTK settings
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc";
    iconTheme.package = pkgs.gnome3.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    gtk2.extraConfig = lib.concatStringsSep "\n" (lib.mapAttrsToList (n: v: "${n}=${v}") {
      gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      gtk-key-theme-name = "Emacs";
    });
    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
        gtk-key-theme-name = "Emacs";
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
