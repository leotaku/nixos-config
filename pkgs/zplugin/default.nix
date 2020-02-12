{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-02-12";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "ef43ab1bb07a6f4677e7ae3b5e97b381384d3051";
    sha256 = "0jqbl3ql01n9srhr3y0f4qn5fisr3v81mkzdh17v91gcsk831wcm";
  };

  buildInputs = [ zsh gnumake ncurses autoconf gcc ];

  configurePhase = ''
    cd zmodules
    ./configure --without-tcsetpgrp
  '';

  installPhase = ''
    cd ..
    cp -r . $out
  '';
}
