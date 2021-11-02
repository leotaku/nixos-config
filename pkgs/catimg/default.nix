{ stdenv, fetchFromGitHub, imagemagick, cmake, lib }:

stdenv.mkDerivation rec {
  pname = "catimg";
  version = "unstable-2021-08-13";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "70e6f5ef627240589378e0e9e527a197faa0acde";
    sha256 = "030gxldh5d3p3sasqabyi03is9wy8slmsbhx38riz0bwf79baig0";
  };

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ imagemagick ];

  meta = with lib; {
    description = "Insanely fast image printing in your terminal";
    homepage = "https://github.com/posva/catimg";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
