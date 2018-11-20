imports = [
  /etc/nixos/nixos-config/external/clever/qemu.nix
];

qemu-user.aarch64 = true;

environment.systemPackages = with pkgs; [
  nixops
  ctop
  htop
  ((import <nixpkgs> {}).stdenv.mkDerivation {
    name = "deployments";
    src = /home/leo/nixos-config/deployments;

    installPhase = ''
      mkdir $out
      mv ./* $out
    '';
  })
];
