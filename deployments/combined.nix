{
  network.description = "Home network";
  network.enableRollback = true;

  nixos-fujitsu = (import ./fujitsu.nix).nixos-fujitsu;
  nixos-rpi = (import ./rpi.nix).nixos-rpi;
}

  

