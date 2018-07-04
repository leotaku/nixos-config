{ stdenv, fetchFromGitHub, imagemagick, cmake }:

stdenv.mkDerivation rec {
  name="catimg";
  version="2929d86";

  src = fetchFromGitHub {
    repo="catimg";
    owner="posva";
    rev="${version}";
    sha256 = "1ha3hg9s2zhcnn9bc3ciskq50sqasqwq1bj712v9yrmk55b2024w";
  };
  
  propagatedBuildInputs = [ imagemagick ];
  buildInputs = [ cmake ];

  buildPhase = "cmake .";
}
