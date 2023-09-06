{ lib, config, pkgs, ... }: {
  imports = [ ../modules/meshify.nix ];

  # Configure network mesh
  meshify = {
    enable = true;
    openFirewall = true;
    servers = {
      "nixos-fujitsu" = {
        external = [ "raw.le0.gs" ];
        internal = "192.169.100.1";
      };
      "nixos-laptop" = { internal = "192.169.100.2"; };
      "nixos-rpi" = { internal = "192.169.100.3"; };
      "fedora-laptop" = { internal = "192.169.100.4"; };
    };
  };

  # Nix build machines
  nix = {
    distributedBuilds = true;
    buildMachines = lib.mapAttrsToList (lib.flip lib.const) {
      "nixos-rpi" = {
        hostName = "nixos-rpi.local";
        systems = [ "aarch64-linux" ];
        speedFactor = 4;
      };
      "nixos-fujitsu" = {
        hostName = "nixos-fujitsu.local";
        systems = [ "x86_64-linux" "wasm32-wasi" "aarch64-linux" ];
        speedFactor = 12;
        supportedFeatures = [ "big-parallel" ];
      };
    };
  };
}
