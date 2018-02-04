# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Import home manager module
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/nixos-module.tar.gz}/nixos"
      # Import Files
      ./users/leo.nix
      ./systems/home.nix
      ./machines/thinkpad.nix
    ];
  nixpkgs.overlays = [ (import ./pkgs) ];
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
