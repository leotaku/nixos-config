let
  pinned = import ../sources/links/nixos-19_09 {};
in {
  network = {
    description = "Home network";
    overlays = [];
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
    pkgs = pinned;
  };
} // {
  "nixos-laptop.local" = {
    configuration = import ./laptop/configuration.nix;
    nixpkgs = ../sources/links/nixos-unstable;
  };
  "nixos-fujitsu.local".configuration = import ./fujitsu.nix;
  "nixos-rpi.local".configuration = import ./rpi.nix;
}
