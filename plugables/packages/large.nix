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
    diskus
    du-dust
    ffmpeg-full
    ffmpegthumbnailer
    httplz
    hyperfine
    imagemagick
    just
    pandoc
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
}
