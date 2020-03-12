{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nix tools
    nix-top
    # Standard utils
    parallel
    file
    tree
    curl
    wget
    psmisc
    stow
    cron
    bc
    unzip
    lsof
    # Networking
    netcat-gnu
    # New utils
    rsync
    moreutils
    # Archives
    gnutar
    libarchive
    # Editors
    neovim
    # Shells
    bash
    dash
    # Hardware
    lm_sensors
  ];
}
