{ stdenv, fetchzip }:

let
  version = "1.0";
in fetchzip {
  name = "besley-${version}";
  url = "https://github.com/indestructible-type/Besley/archive/${version}.zip";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.otf -d $out/share/fonts/opentype
  '';

  sha256="01b2kks59x07jxkgidnj1wa1b22v6nvxs5yfg5n22j5nzzgzkkrr";
}
