{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-02-07";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "67356249c1c344a66b429dab292b21ed45304018";
    sha256 = "14cv5b201ia4s8c52mycm7gaqsgjfk9v0560varqgcllgkjx7qmq";
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
