{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    file
    gnumake
    gnutar
    kakoune
    nftables
    nix-top
    parallel
    psmisc
    rsync
    stow
    tree
    unzip
    zip
  ];
}
