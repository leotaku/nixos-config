{ config, lib, pkgs, ... }:

{
  # Also needs the usability utils
  imports = [
    ./usability.nix
  ];

  environment.systemPackages = with pkgs; [
    # Tools
    aspell-custom
    bat
    config.boot.kernelPackages.perf
    ffmpeg-full
    hyperfine
    imagemagick
    just
    libqalculate
    pandoc
    ripgrep-all
    tokei
  ];

  # Sysctl settings for perf
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };
}
