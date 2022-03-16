{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-03-08";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "3fcec75b7690779e73f7550610a66955ee161e4d";
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
