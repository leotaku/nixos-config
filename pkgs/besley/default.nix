{ stdenv, fetchzip }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "git";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "ccd479844734236911a419cbd40e3f65ecddc71a";
    sha256 = "0z7fkkr37lysmr8cr9jm598j9lzbkyryblwhnl9ni62byjwhhmx8";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/fonts/truetype
    cp Finished\ TTF/*.ttf $out/share/fonts/truetype
    cp Finished\ otf/*.otf $out/share/fonts/opentype
  '';

}
