{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version control
    gitAndTools.gitFull
    mercurial
    darcs
    bazaar
    cvs
    # Archives
    p7zip
    # New utils
    ripgrep
    fd
    rsync
    aria
    # Text-mode utils
    tmux
    screen
    ncdu
    htop
    w3m
    lynx
  ];
}
