{ fetchFromGitHub, stdenv, libX11,  ... }:

stdenv.mkDerivation rec {
  name = "interrobang-${version}";
  version = "321cd9d";

  src = fetchFromGitHub {
    owner = "TrilbyWhite";
    repo = "interrobang";
    rev = "${version}";
    sha256 = "013474fjc970dpbjygx4n67gj82z71l2cfn5w1mg9q84w6wa4mwi";
  };

  hardeningDisable = [ "format" ];
  
  makeFlags = [ "PREFIX=" "DESTDIR=$(out)" ];

  propagatedBuildInputs = [
    libX11
  ];
}
