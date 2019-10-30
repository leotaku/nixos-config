{ config, pkgs, lib, ... }:

{
  # NOTE: Target is managed in main deployment file for convenience.

  # Kernel version
  # FIXME: boot.kernelPackages = pkgs.linuxPackages_latest;

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  
  # Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  boot.kernelParams = ["cma=32M"];

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    #"/boot" = {
    #  device = "/dev/disk/by-label/NIXOS_BOOT";
    #  fsType = "vfat";
    #};
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
