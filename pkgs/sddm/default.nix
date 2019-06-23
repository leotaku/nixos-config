{ stdenv }:
stdenv.mkDerivation rec {
  name = "sddm-themes";
  src = ./.;

  installPhase = ''
    echo $out
    mkdir -p $out/share/sddm/themes
    rm default.nix
    mv * $out/share/sddm/themes/
  '';
}
