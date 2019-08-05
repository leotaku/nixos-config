{ stdenv, fetchzip }:

let
  version = "what";
in fetchzip {
  name = "alegreya-${version}";
  url = "https://www.fontsquirrel.com/fonts/download/alegreya";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.otf -d $out/share/fonts/opentype
  '';

  sha256="00gjmsbv7b2g6ysza26kmr92fc9hn4w7cc587mg6k3riwnq6cavf";
}
