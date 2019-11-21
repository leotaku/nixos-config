{ stdenv, fetchFromGitHub, imagemagick, cmake }:

stdenv.mkDerivation rec {
  name = "catimg";
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
}
