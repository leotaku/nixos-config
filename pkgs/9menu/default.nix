{ stdenv, fetchFromGitHub, libX11, libXext }:

stdenv.mkDerivation rec {
  name="${version}";
  version="9menu-release-2015-06-25";

  src = fetchFromGitHub {
    repo="9menu";
    owner="arnoldrobbins";
    rev="${version}";
    sha256 = "1ypi32bxlm1azihvc6k152l94jj9wpm327fqfr0dlmy6jvd65v2g";
  };
  
  buildInputs = [ libX11 libXext ];
  makeFlags = [ "DESTDIR=$(out)" "BINDIR=/bin" ];
}


