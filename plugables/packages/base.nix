{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    file
    gnumake
    kakoune
    libarchive
    nftables
    ntfs3g
    nix-top
    parallel
    psmisc
    rsync
    stow
    tree
  ];
}
