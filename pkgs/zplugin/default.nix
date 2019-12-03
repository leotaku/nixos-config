{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-02";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "eb06d2d47bcc11224aa9ccb056bd3f897c18a79d";
    sha256 = "020f3kxkii6hlc8kq9wa4y0xgkgs58amq4ds0pydm519ah0wxi25";
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
