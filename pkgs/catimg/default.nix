{ stdenv, fetchFromGitHub, imagemagick, cmake, lib }:

stdenv.mkDerivation rec {
  name = "catimg-${version}";
  version = "2019-06-30";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "d11961941329ba83cd9df567a9774ae06829579a";
    sha256 = "0p604blkhyqgvjdxk36612swf1kapyb18cqp31vs5a8w3rcdd5dd";
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
