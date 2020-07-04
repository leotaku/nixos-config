let
  sources = import ../sources/nix/sources.nix;
  pinned = import sources.nixos-unstable {};
in {
  network = {
    description = "Home network";
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
    # NOTE: evalConfig also passes nixpkgs.pkgs
    lib = pinned.lib;
    evalConfig = pinned.path + "/nixos/lib/eval-config.nix";
    runCommand = pinned.runCommand;
  };
} // {
  "nixos-laptop" = import ./laptop/configuration.nix;
  "nixos-fujitsu" = import ./fujitsu.nix;
  "nixos-rpi" = import ./rpi.nix;
}
