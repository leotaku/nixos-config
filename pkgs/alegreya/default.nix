{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "alegreya-${version}";
  version = "2018-08-08";

  src = fetchFromGitHub {
    owner = "huertatipografica";
    repo = "Alegreya";
    rev = "254c16b651af6926154b9af159c7af8eb908a6ea";
    sha256 = "1m5xr95y6qxxv2ryvhfck39d6q5hxsr51f530fshg53x48l2mpwr";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r fonts/otf $out/share/fonts/opentype
    cp -r fonts/ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "Serif family, part of the Alegreya super family";
    homepage = "https://github.com/huertatipografica/Alegreya";
    license = licenses.ofl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
