{ stdenv, fetchFromGitHub, imagemagick, cmake, lib }:

stdenv.mkDerivation rec {
  name = "catimg-${version}";
  version = "2020-10-09";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "a67b92d8a4db481a1df041e2e2911050b26107d8";
    sha256 = "0gvnh7bilba1vs9ib1l40lzbvf855bsi5z6vgrqj7dh2zhg2aijr";
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
