{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "2021-03-06";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "ef15c1b06fde6b0d51327eed8282dec56c628780";
    sha256 = "1wa45bhqkw7cp72ij8l3cnq46bsvc5km8n11vxdd1xmvwcxi55p1";
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
