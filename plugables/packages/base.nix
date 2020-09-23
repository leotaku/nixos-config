{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    file
    gnumake
    kakoune
    libarchive
    nftables
    nix-top
    parallel
    psmisc
    rsync
    stow
    tree
  ];
}
