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
    ../modules/emacs.nix
    ../modules/qt5ct.nix
    ../modules/xss-lock.nix
    ../plugables/email/home-manager.nix
    ../plugables/picom.nix
    ../plugables/xdg/mimeapps.nix
    ../plugables/xdg/user-dirs.nix
  ];

  home.packages = with pkgs; [
    # Required
    xcape
    xdo
    xorg.xmodmap
    xsel
    z-lua
    zinit-install
    # Text editors
    emacs-git-custom
    vscode-with-extensions
    # GUI applications
    gcolor3
    maim
    pavucontrol
    pinta
    rofi
    sxiv
    syncthing-gtk
    vlc
    xfce.thunar
    # Stupid files
    libreoffice-fresh
    okular
    zathura
    # Terminal
    direnv
    fzf
    gitAndTools.hub
    lorri
    weechat
    # Fonts
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

  # Make fonts work (fonts still don't work)
  fonts.fontconfig.enable = true;

  # User variables
  home.sessionVariables = {
    TERMINAL = "urxvtc";
    EDITOR = "kak";
  };

  # Disable user keyboard configuration
  home.keyboard = null;

  # Lorri + direnv integration
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

  # X settings
  xsession = {
    enable = true;
    preferStatusNotifierItems = true;
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
      size = 32;
    };

    # Ad-hoc X fixes
    initExtra = with pkgs; with xorg; ''
      xcape -e 'ISO_Level3_Shift=Escape'
      xcape -e 'Alt_L=Control_L|G'
      xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" 0.21
      xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 1
    '';

    # AwesomeWM
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ inspect ];
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
    theme.package = pkgs.adapta-gtk-theme;
    theme.name = "Adapta-Eta";
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
      diff.algorithm = "histogram";
    };
  };

  # Systemd settings
  systemd.user.startServices = true;

  # Emacs
  services.emacs-server = {
    enable = true;
    package = pkgs.emacs-git-custom;
    shell = pkgs.zsh + "/bin/zsh -i -c";
  };

  # Enable simple programs and services
  programs.info.enable = true;
  services.blueman-applet.enable = true;
  services.cbatticon.enable = true;
  services.network-manager-applet.enable = true;
  services.syncthing.enable = true;

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
}
