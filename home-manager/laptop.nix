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
    ../plugables/compton.nix
    ../modules/qt5ct.nix
    ../modules/xss-lock.nix
  ];

  home.packages = with pkgs; [
    # Required
    z-lua
    zplugin-install
    # Text editors
    emacs-git-custom
    kakoune
    vscode-with-extensions
    # GUI applications
    gcolor3
    maim
    pavucontrol
    pinta
    rofi
    rxvt-unicode-custom
    screenkey
    simplescreenrecorder
    sxiv
    syncthing-gtk
    vlc
    xfce.thunar
    # Stupid files
    calibre
    libreoffice-fresh
    okular
    zathura
    zotero
    # Terminal
    asciinema
    bvi
    chroma
    direnv
    emv
    exa
    fzf
    gitAndTools.hub
    jq
    libqalculate
    progress
    pulsemixer
    ripgrep-all
    tokei
    weechat
    # Utils
    graphviz
    onefetch
    pandoc
    playerctl
    speedtest-cli
    youtube-dl
    # Lower
    atool
    bashmount
    discount
    exiftool
    id3v2
    libarchive
    mediainfo
    mtpfs
    p7zip
    poppler_utils
    usbutils
    # Xorg
    libnotify
    wmctrl
    xcape
    xdo
    xdotool
    xorg.xmodmap
    xsel
    # Fonts
    fira
    fira-code
    fira-mono
    alegreya
    go-font
    ibm-plex
    source-code-pro
    dejavu_fonts
    symbola
    joypixels
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
    command = "/run/wrappers/bin/slock";
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
      extraCss = builtins.readFile ../files/tweaks.css;
    };
  };

  # Git settings
  programs.git = {
    enable = true;
    userName = "Leo Gaskin";
    userEmail = "leo.gaskin@brg-feldkirchen.at";
    extraConfig = {
      github.user = "leotaku";
    };
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

  # Battery icon
  services.cbatticon.enable = true;

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
          "browser.urlbar.decodeURLsOnCopy" = true;
          "general.autoScroll" = true;
          "network.IDN.whitelist.local" = true;
          "places.history.expiration.max_pages" = 2147483647;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "xpinstall.signatures.required" = false;
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
      "x-scheme-handler/chrome" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
      "application/x-shellscript" = "emacs.desktop";
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
      "inode/directory" = "Thunar-folder-handler.desktop";
      "text/english" = "emacs.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "emacs.desktop";
      "text/x-c" = "emacs.desktop";
      "text/x-c++" = "emacs.desktop";
      "text/x-c++hdr" = "emacs.desktop";
      "text/x-c++src" = "emacs.desktop";
      "text/x-chdr" = "emacs.desktop";
      "text/x-csrc" = "emacs.desktop";
      "text/x-java" = "emacs.desktop";
      "text/x-makefile" = "emacs.desktop";
      "text/x-moc" = "emacs.desktop";
      "text/x-pascal" = "emacs.desktop";
      "text/x-tcl" = "emacs.desktop";
      "text/x-tex" = "emacs.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/chrome" = "userapp-firefox.desktop";
      "x-scheme-handler/ftp" = "userapp-firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/org-protocol" = "org-protocol.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
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

  # Better Emacs(client) desktop
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

  # Run URxvt wit Tmux
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

  # Register org-capture protocol
  xdg.dataFile."applications/org-protocol.desktop".text = ''
    [Desktop Entry]
    Name=org-protocol
    Exec=emacsclient %u
    Type=Application
    Terminal=false
    Categories=System;
    MimeType=x-scheme-handler/org-protocol;
  '';
}
