# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  imports = [ 
    # Import configuration
    ./leo.nix
    ./system.nix
    ../hardware/thinkpad.nix
    ../plugables/builders/all.nix
    # Import home manager module
    ../sources/links/home-manager/nixos
    # Import quemu module
    ../sources/external/clever/qemu.nix
  ];

  nix.trustedUsers = [ "root" "@wheel" ];
  
  qemu-user.aarch64 = true;
  nix.distributedBuilds = true;
  
  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/sources/links/nixos-unstable"
    "nixos-config=/etc/nixos/configuration.nix"
    "sources=/etc/nixos/nixos-config/sources/nix/sources.nix"
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
