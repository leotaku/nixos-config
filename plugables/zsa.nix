{ config, pkgs, lib, ... }: {
  # Udev support for Oryx and Wally
  services.udev.packages = [ pkgs.zsa-udev-rules ];

  # Add plugdev group
  users.groups.plugdev = { };
}
