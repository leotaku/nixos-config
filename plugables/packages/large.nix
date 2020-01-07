{ config, lib, pkgs, ... }:

{
  # Also needs the usability utils
  imports = [
    ./usability.nix
  ];
  
  environment.systemPackages = with pkgs; [
    # Tools
    pandoc
    bat
    hyperfine
    du-dust
    diskus
    imagemagick
    ffmpegthumbnailer
    ffmpeg-full
    httplz
    # Toys
    neofetch
    cowsay
    lolcat
    fortune
    sl
    asciiquarium
    cmatrix
    figlet toilet
  ];
}
