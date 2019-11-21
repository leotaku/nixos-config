{ stdenv, fetchFromGitHub, cairo }:

stdenv.mkDerivation rec {
  name = "n30f";
  version = "2019-02-07";

  src = fetchFromGitHub {
    repo = "n30f";
    owner = "sdhand";
    rev = "e10e3c7c3cf10def0151eaf1ae4d7a8169c20503";
    sha256 = "14xndwnq7ab2x04bk599z0dxv3f8q3kmzfwsq35qwi4c6i04h4y9";
  };

  buildInputs = [ cairo ];
  makeFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
}
