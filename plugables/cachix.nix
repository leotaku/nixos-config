{ config, pkgs, lib, ... }:

{
  # Manually trust @wheel users
  nix.settings.trusted-users = [ "leo" ];

  environment.systemPackages = [
    pkgs.cachix
  ];
}
