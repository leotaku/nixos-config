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
    update-nix-fetchgit
    # Utils
    aria
    bvi
    emv
    entr
    exiftool
    fd
    ffsend
    git
    git-lfs
    jdupes
    jq
    qrencode
    rclone
    ripgrep
    sops
    wget
    # Text-mode utils
    htop
    ncdu
    rlwrap
    tmux
    # Networking
    dnsutils
    nethogs
    nmap
    speedtest-cli
  ];
}
