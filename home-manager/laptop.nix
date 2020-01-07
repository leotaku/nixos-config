{ config, lib, pkgs, ... }:

{
  # Home-manager bootstrap idiocy
  programs.home-manager.enable = true;
  programs.home-manager.path = toString
    (import ../sources/nix/sources.nix).home-manager;

  # Nixpkgs like everywhere else
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ (import ../pkgs/default.nix) ];
  };

  # Modules and pluggable configurations
  imports = [
    ../plugables/email/home-manager.nix
    ../plugables/compton/module.nix
    ../modules/qt5ct.nix
    ../modules/xss-lock.nix
  ];

  home.packages = with pkgs; [
    # Required
    xcape
    z-lua
    # Control
    pulsemixer
    pavucontrol
    # Text editors
    kakoune
    vscode-with-extensions
    # File Manager
    xfce.thunar
    emv
    fzf
    # Other
    zotero
    youtube-dl
    # Chat
    weechat
    # Images
    sxiv
    feh
    pinta
    gcolor3
    # PDF
    zathura
    # Video
    vlc
    # Recording
    maim
    simplescreenrecorder
    screenkey
    asciinema
    # Ebook
    calibre
    # Terminal
    rxvt-unicode-custom
    # Network
    speedtest-cli
    # Xorg
    xsel
    xorg.xmodmap
    xdo
    xdotool
    wmname
    wmctrl
    libnotify
    # Utils
    exa
    ripgrep-all
    progress
    # FIXME: chroma
    jq
    tokei
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
    # Fonts
    fira
    fira-code
    fira-mono
    source-code-pro
    ibm-plex
    alegreya
  ];

  # Enable automatic indexing of info files
  programs.info.enable = true;
  
  # Make fonts work (fonts still don't work)
  fonts.fontconfig.enable = true;

  # User variables
  home.sessionVariables = {
    TERMINAL = "urxvtc";
    EDITOR = "kak";
  };

  # FIXME: Disable user keyboard configuration
  home.keyboard = null;

  # Lorri + direnv integration
  services.lorri.enable = true;
  xdg.configFile."direnv/direnvrc".text = ''
    use_nix () {
        eval "$(lorri direnv)"
    }
  '';

  # Redshift
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };

  # MPD
  services.mpd = {
    enable = true;
    musicDirectory = config.home.homeDirectory + "/sync/music";
  };
  services.mpdris2 = {
    enable = true;
    notifications = true;
  };

  # X settings
  xsession = {
    enable = true;
    preferStatusNotifierItems = true;
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
      size = 32;
    };

    # AwesomeWM
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ lgi ];
    };
  };

  # Screen locking
  services.xss-lock = {
    enable = true;
    notifyCmd = [
      "${pkgs.libnotify}/bin/notify-send"
      "Screensaver:"
      "Locking screen in about 5 minutes"
    ];
    lockCmd = [
      (pkgs.i3lock-color + "/bin/i3lock-color")
      "-c" "000000"
    ];
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
    "Emacs.toolBar" = "off";
    "Emacs.menuBar" = "off";
    "Emacs.verticalScrollBars" = "off";
  };

  # QT settings
  qt5ct = {
    enable = true;
    impure = true;
    scale = 1.0;
    theme.package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    iconTheme.package = pkgs.papirus-icon-theme;
    fonts = {
      general.package = pkgs.fira;
      fixed.package = pkgs.fira-mono;
    };
    extraPackages = with pkgs; [ breeze-qt5 breeze-icons ];
  };
  
  # GTK settings
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";
    gtk2 = {
      extraConfig = lib.concatStringsSep "\n" (lib.mapAttrsToList (n: v: "${n}=${v}") {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      });
    };
    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      };
      extraCss = builtins.readFile ./tweaks.css;
    };
  };

  # Git settings
  programs.git = {
    enable = true;
    userName = "leotaku";
    userEmail = "leo.gaskin@brg-feldkirchen.at";
  };

  # Systemd settings
  systemd.user.startServices = true;

  # Syncthing client
  services.syncthing = {
    enable = true;
    tray = false;
  };

  # Kdeconnect
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;

  # Blueman applet
  services.blueman-applet.enable = true;

  # NetworkManager applet
  services.network-manager-applet.enable = true;

  # Firefox settings
  programs.firefox = {
    enable = true;
    package = pkgs.mozilla.firefox-devedition-bin-unwrapped.overrideAttrs
    (oldAttrs: { name = "firefox"; });
    profiles = {
      "dev-edition-default" = {
        id = 0;
        isDefault = true;
        settings = {
          "xpinstall.signatures.required" = false;
          "browser.urlbar.decodeURLsOnCopy" = true;
          "network.IDN.whitelist.local" = true;
          "places.history.expiration.max_pages" = 2147483647;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "general.autoScroll" = true;
        };
      };
    };
  };
  
  # Xdg dirs
  xdg.configFile."user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME"
    XDG_DOWNLOAD_DIR="$HOME/downloads"
    XDG_DOCUMENTS_DIR="$HOME/sync/documents"
    XDG_MUSIC_DIR="$HOME/sync/music"
    XDG_PICTURES_DIR="$HOME/sync/images"
    # Unused:
    XDG_VIDEOS_DIR="$HOME/sync/videos"
    XDG_TEMPLATES_DIR="$HOME/sync/templates"
    # Wrogly used:
    XDG_PUBLICSHARE_DIR="$HOME/repos"
  '';

  # Xdg default applications
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https"  = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/chrome"  = "firefox.desktop";
    };
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/ftp" = "userapp-firefox.desktop";
      "x-scheme-handler/chrome" = "userapp-firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "inode/directory" = "Thunar-folder-handler.desktop";
      "image/bmp" = "sxiv.desktop";
      "image/gif" = "sxiv.desktop";
      "image/jpeg" = "sxiv.desktop";
      "image/jpg" = "sxiv.desktop";
      "image/png" = "sxiv.desktop";
      "image/tiff" = "sxiv.desktop";
      "image/x-bmp" = "sxiv.desktop";
      "image/x-portable-anymap" = "sxiv.desktop";
      "image/x-portable-bitmap" = "sxiv.desktop";
      "image/x-portable-graymap" = "sxiv.desktop";
      "image/x-tga" = "sxiv.desktop";
      "image/x-xpixmap" = "sxiv.desktop";
      "text/plain" = "emacs.desktop";
      "text/english" = "emacs.desktop";
      "text/x-makefile" = "emacs.desktop";
      "text/x-c++hdr" = "emacs.desktop";
      "text/x-c++src" = "emacs.desktop";
      "text/x-chdr" = "emacs.desktop";
      "text/x-csrc" = "emacs.desktop";
      "text/x-java" = "emacs.desktop";
      "text/x-moc" = "emacs.desktop";
      "text/x-pascal" = "emacs.desktop";
      "text/x-tcl" = "emacs.desktop";
      "text/x-tex" = "emacs.desktop";
      "application/x-shellscript" = "emacs.desktop";
      "text/x-c" = "emacs.desktop";
      "text/x-c++" = "emacs.desktop";
    };
  };

  # Firefox does not register a proper entry by default
  xdg.dataFile."applications/firefox.desktop".text = ''
    [Desktop Entry]
    Encoding=UTF-8
    Name=Mozilla Firefox
    GenericName=Web Browser
    Comment=Browse the Web
    Exec=firefox
    Icon=firefox
    Terminal=false
    Type=Application
    Categories=Application;Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;
    StartupNotify=True
  '';

  # Better emacs(client) desktop
  xdg.dataFile."applications/emacs.desktop".text = ''
    [Desktop Entry]
    Name=Emacsclient
    GenericName=Text Editor
    Comment=Edit text
    MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
    Exec=emacsclient -c %F --alternate-editor=""
    Icon=emacs
    Type=Application
    Terminal=false
    Categories=Development;TextEditor;
    StartupWMClass=Emacs
    Keywords=Text;Editor;
  '';

  xdg.dataFile."applications/rxvt-unicode.desktop".text = ''
    [Desktop Entry]
    Encoding=UTF-8
    Name=URxvt
    GenericName=Tmux in Terminal
    Comment=
    Exec=tmux
    Icon=terminal
    Terminal=true
    Type=Application
    Categories=Application;Development;
  '';
}
