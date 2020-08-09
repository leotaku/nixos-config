{ config, lib, pkgs, ... }:

{
  # Also needs the base utils
  imports = [
    ./base.nix
  ];

  environment.systemPackages = with pkgs; [
    # Nix Tools
    nix-top
    nix-diff
    nix-index
    nix-prefetch-scripts
    nixfmt
    # Utils
    aria
    bvi
    ffsend
    emv
    entr
    fd
    gitAndTools.gitFull
    jq
    qrencode
    rclone
    ripgrep
    # Text-mode utils
    htop
    ncdu
    rlwrap
    tmux
    # Hardware
    hwinfo
    pciutils
    # Networking
    dnsutils
    speedtest-cli
    iftop
    iperf
    nmap
  ];
}
