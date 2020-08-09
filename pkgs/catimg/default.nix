{ stdenv, fetchFromGitHub, imagemagick, cmake, lib }:

stdenv.mkDerivation rec {
  name = "catimg-${version}";
  version = "2020-07-31";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "5e096faa751b8f4eef04ccae923c9aa344dd2e9d";
    sha256 = "0a2dswbv4xddb2l2d55hc43lzvjwrjs5z9am7v6i0p0mi2fmc89s";
  };

  propagatedBuildInputs = [ imagemagick ];
  buildInputs = [ cmake ];

  buildPhase = "cmake .";

  meta = with lib; {
    description = "Insanely fast image printing in your terminal";
    homepage = "https://github.com/posva/catimg";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
