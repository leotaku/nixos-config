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
    unzip
    lsof
    zip
    # Networking
    netcat-gnu
    # New utils
    rsync
    moreutils
    # Archives
    gnutar
    libarchive
    # Editors
    kakoune
    # Hardware
    lm_sensors
  ];
}
