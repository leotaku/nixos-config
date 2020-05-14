{ config, pkgs, ... }: {
  imports = [
    ../modules/fleet.nix
  ];

  fleet = {
    enable = true;
    machines = {
      "nixos-laptop".system = "x86_64-linux";
      "nixos-rpi".system = "aarch64-linux";
      "nixos-fujitsu" = {
        system = "x86_64-linux";
        speedFactor = 8;
        supportedFeatures = [ "big-parallel" ];
      };
    };
    base = "/home/leo/.ssh";
  };

  programs.ssh.extraConfig = ''
    Host *.local
    StrictHostKeyChecking no
  '';
}
