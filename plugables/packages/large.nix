{ config, lib, pkgs, ... }:

{
  # Also needs the usability utils
  imports = [ ./usability.nix ];

  environment.systemPackages = with pkgs; [
    aspell-custom
    bat
    config.boot.kernelPackages.perf
    direnv
    ffmpeg-full
    haskellPackages.update-nix-fetchgit
    hyperfine
    imagemagick
    just
    ledger
    libqalculate
    lorri
    pandoc
    ripgrep-all
    tokei
    weechat
    z-lua
  ];

  # Sysctl settings for perf
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };
}
