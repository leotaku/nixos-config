{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-24";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "48bce17b916a188a680f2f440d2f65c75ce615a0";
    sha256 = "10qnrbcaxdsf5f5x2ancd8nh0hb2j36x6npwrxpxmalksvn40ha2";
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
