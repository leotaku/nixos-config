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
    # FIXME: nix-diff
    nix-index
    nix-prefetch-scripts
    # Version control
    gitAndTools.gitFull
    mercurial
    # FIXME: darcs
    bazaar
    cvs
    # Archives
    p7zip
    # New utils
    ripgrep
    fd
    aria
    libqalculate
    entr
    # Multiplexer
    tmux
    screen
    # Text-mode utils
    ncdu
    htop
    w3m
    lynx
    rlwrap
    # Hardware
    hwinfo
    lshw
    stress
    s-tui
    pciutils
    # Networking
    speedtest-cli
    iperf
    nmap
    # Misc
    qrencode
  ];
}
