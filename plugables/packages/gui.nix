{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Xorg
    awesome
    cbatticon
    picom
    xcape
    xdo
    xsel
    # Theming
    adapta-gtk-theme
    breeze-qt5
    gnome3.adwaita-icon-theme
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    papirus-icon-theme
    # GUI applications
    discord
    emacs-git-custom
    inkscape
    krita
    lxappearance
    maim
    pavucontrol
    pinta
    pkgs.mozilla.firefox-devedition-bin
    qt5ct
    rofi
    sxiv
    syncthing
    vlc
    xfce.thunar
    zathura
  ];

  fonts.fonts = with pkgs; [
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
}
