{ stdenv, fetchFromGitHub, imagemagick, cmake }:

stdenv.mkDerivation rec {
  name = "catimg";
  version = "2019-03-10";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "091f02157532a32672a00327a1004230036f1f3f";
    sha256 = "0li63bxyll9593vch1g2w5x9qj4mpdv2lxkg2kf1v6gb2ahpf0n6";
  };

  propagatedBuildInputs = [ imagemagick ];
  buildInputs = [ cmake ];

  buildPhase = "cmake .";
}
