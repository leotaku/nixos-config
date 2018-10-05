imports = [
  /etc/nixos/nixos-config/external/clever/qemu.nix
];

qemu-user.aarch64 = true;

environment.systemPackages = with pkgs; [
  nixops
  ctop
  htop
];
