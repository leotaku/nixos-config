{ config, pkgs, ... }: {
  imports = [
    ../modules/fleet.nix
  ];

  fleet = {
    enable = true;
    machines = {
      # FIXME: Why does local remote not work?
      #"nixos-laptop.local".system = "x86_64-linux";
      "nixos-fujitsu.local".system = "x86_64-linux";
      "nixos-rpi.local".system = "aarch64-linux";
    };
    base = "/home/leo/.ssh";
  };

  programs.ssh.extraConfig = ''
    Host *.local
    StrictHostKeyChecking no
  '';

  nix.extraOptions = "builders-use-substitutes = true";
}
