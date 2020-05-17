{ stdenv, fetchzip }:

let
  version = "2.008";
in fetchzip {
  name = "alegreya-${version}";
  url = "https://github.com/huertatipografica/Alegreya/archive/v${version}.zip";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile Alegreya-2.008/fonts/otf/\*.otf -d $out/share/fonts/opentype
    unzip -j $downloadedFile Alegreya-2.008/fonts/ttf/\*.ttf -d $out/share/fonts/truetype
  '';

  sha256="058s3r3bgrx1ddhjqlq499qiznq9qmxlvfq9jrh9l40pngpf18ar";
}
