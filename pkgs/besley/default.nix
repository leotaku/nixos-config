{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-04-16";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "656ef7a724d17f01b9c01acd8713c15cd876ee4b";
    sha256 = "0xivw5x7w2vrravl8v4843vqinxl0q9kx8s89y1xy0c3fgsm52na";
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
