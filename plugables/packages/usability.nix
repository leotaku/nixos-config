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
    haskellPackages.update-nix-fetchgit
    # Utils
    aria
    bvi
    emv
    entr
    fd
    ffsend
    git
    git-lfs
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
