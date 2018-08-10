{ stdenv, fetchFromGitHub, xorg }:

stdenv.mkDerivation rec {
  name="xgetres-${version}";
  version="1.0";

  src = fetchFromGitHub {
    repo="xgetres";
    owner="tamirzb";
    rev="${version}";
    sha256 = "04cnv8im6sjgrmpcp6qsj73wqk4pql95ja7s3p8f3h3jrsgrvbv8";
  };

  propagatedBuildInputs = [ xorg.libX11 ];
  makeFlags = [ "PREFIX=$(out)" ];
}


