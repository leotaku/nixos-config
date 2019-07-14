{ config, lib, pkgs, ... }:

{

  # Also needs the base utils
  imports = [
    ./base.nix
  ];
  
  environment.systemPackages = with pkgs; [
    # Nix Tools
    nix-top
    nix-du
    nix-index
    nix-prefetch-scripts
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
    aria
    libqalculate
    # Multiplexer
    tmux
    screen
    # Text-mode utils
    ncdu
    htop
    w3m
    lynx
    # Hardware
    hwinfo
    stress
    s-tui
    # networking
    speedtest-cli
    iperf
  ];
}
