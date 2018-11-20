# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  imports = [ 
    # Import home manager module
    "${(import ./sources).libs.home-manager}/nixos"
    # Import Files
    ./users/leo.nix
    ./systems/home.nix
    ./machines/thinkpad.nix
    "${(import ./sources).libs.clever}/qemu.nix"
  ];

  #nixpkgs.pkgs = pkgs;

  qemu-user.aarch64 = true;

  nix.trustedUsers = [ "root" "@wheel" ];

  nix.distributedBuilds = true;
  nix.buildMachines = [
    { hostName = "nixos-rpi.local";
      sshUser = "root";
      sshKey = "/home/leo/.ssh/id_rsa";
      system = "aarch64-linux";
      maxJobs = 2;
    }
  ];
  
  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/sources/mutable/system"
    "nixos-config=/etc/nixos/configuration.nix"
    "sources=/etc/nixos/sources"
    
    #"home-manager=/etc/nixos/nixos-config/sources/mutable/home-manager"
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
