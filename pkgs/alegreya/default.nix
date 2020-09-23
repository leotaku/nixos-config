{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "alegreya-${version}";
  version = "2020-09-23";

  src = fetchFromGitHub {
    owner = "huertatipografica";
    repo = "Alegreya";
    rev = "eb033184ee41de50ec1e1d91b7503367fcc2a4cc";
    sha256 = "1zpra8lgm2qnq015mal692h19f6f3bcs9i35xnvf8mfcsjzqdshb";
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
