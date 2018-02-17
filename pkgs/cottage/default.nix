{ fetchFromGitHub, stdenv, ...}:

stdenv.mkDerivation rec {
  name = "cottage-${version}";
  version = "master";

  src = fetchFromGitHub {
    owner = "HarveyHunt";
    repo = "cottage";
    rev = "${version}";
    sha256 = "1y8r9as1c40n4zcqbn312gg9pq719i0pcy8g15jb7xsrq21lan1m";
  };

  makeFlags = [ "PREFIX=$(out)" ];
}
