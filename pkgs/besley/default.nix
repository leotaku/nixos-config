{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "2021-01-05";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "ffe1f3ab836974c0881967de2dbb0c6c486f1ec9";
    sha256 = "09c1vyakfm7k3haxclsxb05q23lnhp2vimhmc899xf2yg7cqvq7f";
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
