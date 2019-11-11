{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nix tools
    nix-top
    # Standard utils
    file
    tree
    curl
    wget
    psmisc
    stow
    cron
    bc
    unzip
    # new utils
    rsync
    moreutils    
    # Archives
    gnutar
    libarchive
    # Editors
    vim
    # Shells
    bash
    dash
    # Hardware
    lm_sensors
    # Ensure "special" terminfo
    kitty.terminfo
    rxvt_unicode.terminfo
  ];
}
