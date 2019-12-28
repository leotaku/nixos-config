let
  sources = import ../sources/nix/sources.nix;
  pinned = import sources.nixos-19_09-small { };
in {
  network = {
    description = "Home network";
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
    pkgs = pinned;
  };
} // {
  "nixos-laptop.local" = {
    configuration = import ./laptop/configuration.nix;
    nixpkgs = sources.nixos-unstable;
  };
  "nixos-fujitsu.local".configuration = import ./fujitsu.nix;
  "nixos-rpi.local".configuration = import ./rpi.nix;
}
