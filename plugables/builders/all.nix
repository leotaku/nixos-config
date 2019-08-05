{ config, pkgs, ... }:
{
  nix.buildMachines = [ 
    { sshUser = "root";
      sshKey = "/home/leo/.ssh/id_rsa";
	    hostName = "nixos-rpi.local";
	    system = "aarch64-linux";
	    maxJobs = 2;
	    speedFactor = 1;
	    supportedFeatures = [ ];
	    mandatoryFeatures = [ ];
    }
    { sshUser = "root";
      sshKey = "/home/leo/.ssh/id_rsa";
	    hostName = "nixos-fujitsu.local";
	    system = "x86_64-linux";
	    maxJobs = 12;
	    speedFactor = 12;
	    supportedFeatures = [ "big-parallel" ];
	    mandatoryFeatures = [ ];
    }
  ];

  programs.ssh.knownHosts = {
    rpi = {
      hostNames = [ "nixos-rpi.local" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQChRNYgHmg0hJObuZaD7g1fUDvH8c9JiiqH7Z8uXFeBp9x389ZNC/vr4tUdkkjSiVIKnPxNSXMEoa/Z8eBna1KjTPHBzyKIVw0DYsgue9Sormle5mH9fnT1s3u7Q0crnJ+VESDZ4DezzmhNJkaTtafL+SpXQ3EPjAhTbVxWpYJMsEglPRSDS8M7IDOc4kXR6LqVbu6BP3l+AHK+IzTRrYwKZEh3JpaEkVG1RIjoKf/isoKLTzrT2+I+V77gQK7TDLuuU8x9RM6Rmq5b7KD1Hi/NRnPM+P0J9KK1WgQ/k0wt0hmgD+lKYZOfdZGPpPyZH9VUaRACfyeB0tIbEBfrV0JU/z8m64scR5MzHO+l9B9sl9NZm4Z2TMx5rQ1xu7P8z0LR1DG9KGWtUX3szrLs4m+lZ+Yo6qgwGgCjElciRd8tS0HNLfpszKBNkVa1aNw5CXdkBCc2zH7iCFUV51pEK5HHrr5GseICiX67CdVy0+NMTut0cyEGhLLU/ElcuYn8PpPSXwjtb0oFamaBUFVyR/wKB6TH2R5CegUmFtcqXtv7yp11kqJ4rn/HCnFnLW+V2Ki2Fij1t3PFoPAvcJjiQsPuUUxdEvgcNip478FtexAEHbgakyHhXyGql+bFxp0y1rprIHO5BGiImCY+yaQ9HPnTweTWyU2AO7aOOFY4qhjmqQ==";
    };
    fujitsu = {
      hostNames = [ "nixos-fujitsu.local" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2k9uCcisvhiFyrJ/4hZ9LJb4vEo1AcTYMxLUT6oy72ebsVCfZor/f810KevMTjZu7LGCFVa6TOYsHCjkebbXDsZJ+L4Gy7GCtGDBdOpD5ToUnR+Q0LlSf9VfBWnr2jpdbkjiF1/j8QPOm4XoO3BPXFPWlRo7grWAItOgbefgEzq2UDCTGgqcr9p+AxJHNRMB50gkQtgvW8Zbci630ho+Wt58Cc772tVtzb+OqaiVFAm0bz/cW5Naej9AcjCincSgZ5Ew1LL9oc/JupII/0Lm3NRxvyXkO9LOVdYcHN5EhugHk2wBVohRzQ7bKbxbUDDup9zj/hQkSBXxwtfQ/s17XlStFMrVKt5aN2z1tpk1cLkI1DHrUSq5AbnaZwbZx2r0IRhL8S+aqZa+R3/PCBWqGCmXimCCupcD+BpA2PXxJWOjE8VNFHk9JvD8ayYHYG1h8y5AIdRq8UQ9vXMvQcnwkP+LzsvlKJ+5vtvnWJWSAmnPPNPCRB44jLaYTaWWwnT6bPwtlgISDQcXkY8JkAxP4AZz75SnTOTVznSpcBoutZviD/KZ3qr4hzpgKUemFJhZKAZwCD4Lf8Y0u1OV9IIPbcS2+zxo5T3cKV/OG0D2pDXJEA+V/o2WUJmgvCWrIFRqATEwCh8QuBghqvQ6lA8Sbtep/peg2NHycZbsl2wDfew==";
    };
  };

  # optional, useful when the builder has a faster internet connection than yours
	nix.extraOptions = ''
		builders-use-substitutes = true
	'';
}
