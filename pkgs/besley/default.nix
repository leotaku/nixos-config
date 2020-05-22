{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "2019-06-07";

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

  meta = with lib; {
    description = "An original font created by indestructible type*";
    homepage = "https://github.com/indestructible-type/Besley";
    license = licenses.ofl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
