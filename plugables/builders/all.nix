{ config, pkgs, ... }:
{
  nix.buildMachines = [ 
    { sshUser = "root";
      sshKey = "/root/.ssh/test_builder";
	    hostName = "nixos-rpi.local";
	    system = "aarch64-linux";
	    maxJobs = 2;
	    speedFactor = 1;
	    supportedFeatures = [ ];
	    mandatoryFeatures = [ ];
    }
    { sshUser = "root";
      sshKey = "/root/.ssh/nix_remote";
	    hostName = "nixos-fujitsu.local";
	    system = "x86_64-linux";
	    maxJobs = 12;
	    speedFactor = 12;
	    supportedFeatures = [ "big-parallel" ];
	    mandatoryFeatures = [ ];
    }
  ];

  # optional, useful when the builder has a faster internet connection than yours
	nix.extraOptions = ''
		builders-use-substitutes = false
	'';
}
