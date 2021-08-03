{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "2021-03-06";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "eb8b1b7f62f9f328e4be345d3e5928fefba3c38e";
    sha256 = "07n1m3859ixs1gwm3421vxz1axhvf8my1bbc7wlvgrfz0ym4y3cv";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp fonts/ttf/* $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "An original font created by indestructible type*";
    homepage = "https://github.com/indestructible-type/Besley";
    license = licenses.ofl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
