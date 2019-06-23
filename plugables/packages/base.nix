{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nix Tools
    nix-top
    nix-du
    nix-index
    nix-prefetch-scripts
    # Standard utils
    file
    tree
    curl
    wget
    moreutils
    psmisc
    stow
    cron
    bc
    # Version control
    gitAndTools.gitFull
    # Archives
    gnutar
    libarchive
    # Editors
    nvi
    # Shells
    bash
    dash
    # Terminal toys
    figlet
    toilet
    fortune
    cowsay
    lolcat
    neofetch
  ];
}
