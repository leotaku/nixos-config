{ stdenv, fetchzip, lib }:

stdenv.mkDerivation rec {
  name = "alegreya-${version}";
  version = "2.008";

  src = fetchzip {
    url = "https://github.com/huertatipografica/Alegreya/archive/v${version}.zip";
    sha256 = "sha256-md8qKCJ9lAe1A6O4ULLusGDT0pjMwe2z2L1j40vKvdQ=";
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
