{ stdenv, fetchFromGitHub, imagemagick, cmake }:

stdenv.mkDerivation rec {
  name="catimg";
  version="2018-12-15";

  src = fetchFromGitHub {
    repo="catimg";
    owner="posva";
    rev="a89d10be68bdd3dbd9286b191710384ca4c33253";
    sha256 = "0v07sjx6xxri6dg9cib6i9281y27pclnif4mfim9gnlfzmwwfyyd";
  };
  
  propagatedBuildInputs = [ imagemagick ];
  buildInputs = [ cmake ];

  buildPhase = "cmake .";
}
