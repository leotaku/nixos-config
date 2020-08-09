{ lib, config, pkgs, ... }: {
  imports = [ ../modules/fleet.nix ];

  # Fleet machines
  fleet = {
    enable = true;
    machines = {
      "nixos-laptop" = {
        hostName = "192.168.178.54";
        system = "x86_64-linux";
      };
      "nixos-rpi" = {
        hostName = "192.168.178.23";
        system = "aarch64-linux";
      };
      "nixos-fujitsu" = {
        hostName = "192.168.178.48";
        system = "x86_64-linux";
        speedFactor = 8;
        supportedFeatures = [ "big-parallel" ];
      };
    };
    base = "/home/leo/.ssh";
  };

  # Generate '.local' host entries
  networking.extraHosts = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (n: v: "${v.hostName} ${n}.local")
      config.fleet.machines);
}