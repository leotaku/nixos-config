{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Xorg
    awesome-git
    cbatticon
    picom
    xcape
    xdo
    xorg.xkbcomp
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
    firefox-devedition-bin
    emacs-git-custom
    inkscape
    krita
    lxappearance
    maim
    mpv
    pavucontrol
    pinta
    qt5ct
    rofi
    sxiv
    syncthing
    xfce.thunar
    zathura
  ];

  fonts.fonts = with pkgs; [
    # Fonts
    alegreya
    dejavu_fonts
    fira-code
    fira-mono
    go-font
    ibm-plex
    jetbrains-mono
    joypixels
    source-code-pro
    symbola
  ];

  nixpkgs.config.joypixels.acceptLicense = true;
}
