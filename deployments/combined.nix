let pinned = import ../sources/links/nixos-19_03 {};
in with pinned.lib;
let
  subnetwork = file:
    let
      submodule = import file;
      machines = attrsets.filterAttrs (n: _: n != "network") submodule;
      pkgs = submodule.network.pkgs;
    in machines;
in {
  network = {
    description = "Home network";
    enableRollback = true;
    overlays = [];
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
    pkgs = pinned;
  };
} // subnetwork ./fujitsu.nix // subnetwork ./rpi.nix
