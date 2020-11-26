{ config, pkgs, ... }:

{
  services.xserver = {
    layout = "de";
    xkbVariant = "leo";
  };

  nixpkgs.overlays = [ (import ./default.nix) ];
}
