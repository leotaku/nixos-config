{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-04-10";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "4df6f13f2a9b160e9c7c7497543f1a014eb70f6a";
    sha256 = "0sx7k8dq8w54d5bskvl589f4yjgnggszazmmi97bda3pbpwr7x6p";
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
