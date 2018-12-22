# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  imports = [ 
    # Import configuration
    ./users/leo.nix
    ./systems/home.nix
    ./machines/thinkpad.nix
    # Import home manager module
    ./sources/links/libs/home-manager/nixos
    # Import quemu module
    #./sources/links/libs/clever/qemu.nix
    ./sources/external/clever/qemu.nix
  ];

  qemu-user.aarch64 = true;

  nix.trustedUsers = [ "root" "@wheel" ];

  nix.distributedBuilds = true;
  nix.buildMachines = [ {
    sshUser = "root";
    sshKey = "/root/.ssh/test_builder";
	  hostName = "nixos-rpi.local";
	  system = "aarch64-linux";
	  maxJobs = 2;
	  speedFactor = 2;
	  supportedFeatures = [ " big-parallel" ];
	  mandatoryFeatures = [ ];
	}];
  
  # optional, useful when the builder has a faster internet connection than yours
	nix.extraOptions = ''
		builders-use-substitutes = true
	'';

  nix.nixPath = [
    "/etc/nixos/nixos-config"
    "nixpkgs=/etc/nixos/nixos-config/sources/links/nixpkgs/system"
    "nixos-config=/etc/nixos/configuration.nix"
    "sources=/etc/nixos/nixos-config/sources/lock.nix"
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
