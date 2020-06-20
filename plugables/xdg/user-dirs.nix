{ config, lib, pkgs, ... }:

{
  xdg.configFile."user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME"
    XDG_DOWNLOAD_DIR="$HOME/downloads"
    XDG_DOCUMENTS_DIR="$HOME/sync/documents"
    XDG_MUSIC_DIR="$HOME/sync/music"
    XDG_PICTURES_DIR="$HOME/sync/images"
    # Unused:
    XDG_VIDEOS_DIR="$HOME/sync/videos"
    XDG_TEMPLATES_DIR="$HOME/sync/templates"
    # Wrogly used:
    XDG_PUBLICSHARE_DIR="$HOME/repos"
  '';
}
