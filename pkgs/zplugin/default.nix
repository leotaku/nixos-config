{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-13";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "1977d4632d806fb3789f0c8c9cbd29d788c20dff";
    sha256 = "19k5cd7jrz3db4jrl8kjqj10sa2k69dvcilnxx9w2lb9ypw8arg9";
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
