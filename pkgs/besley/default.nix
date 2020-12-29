{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "besley-${version}";
  version = "2020-12-20";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "df0697d9648efbf3c2b13badabe5f174ac79c2b1";
    sha256 = "1q9gmnj261snk2jcs4j7ibsp12zllhk6frc8ippc06gs02yhyb31";
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
