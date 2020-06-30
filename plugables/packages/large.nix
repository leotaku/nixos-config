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
    diskus
    du-dust
    ffmpeg-full
    ffmpegthumbnailer
    httplz
    hyperfine
    imagemagick
    just
    pandoc
    ripgrep-all
    # Toys
    asciiquarium
    cmatrix
    cowsay
    figlet toilet
    fortune
    lolcat
    neofetch
    sl
  ];

  # Sysctl settings for perf
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };
}
