{ config, lib, pkgs, ... }:

{
  # Also needs the base utils
  imports = [ ./base.nix ];

  environment.systemPackages = with pkgs; [
    # Nix Tools
    nix-diff
    nix-index
    nix-prefetch-scripts
    nix-top
    nixfmt
    # Utils
    aria
    bvi
    emv
    entr
    fd
    ffsend
    gitAndTools.gitFull
    gitAndTools.hub
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
    dnsutils
    speedtest-cli
    nmap
  ];
}
