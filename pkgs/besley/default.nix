{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-05-18";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "c87ddc8b1d852033865cb52680b6bddb3da1b943";
    sha256 = "1zlz2bnd7hrhr5ywzyisjh42kcf99k4jkan65b2jmv91gyvcb2dv";
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
