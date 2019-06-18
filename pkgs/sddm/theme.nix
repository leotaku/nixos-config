{ stdenv }:
stdenv.mkDerivation rec {
  name = "sddm-theme";
  src = ./src;

  installPhase = ''
    echo $out
    mkdir -p $out/share/sddm/themes/test
    mv * $out/share/sddm/themes/test
  '';
}
