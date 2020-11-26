# Edit this configuration file to define an users configurations
# on your systems. Help is available in the configuration.nix(5)
# man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Define an user account. Don't forget to set a password with ‘passwd’.
  users.users.leo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "vboxusers"
      "video"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.bash;
  };
}
