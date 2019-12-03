{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-11-26";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "6fc03f5f837f79b18e83a2affcb6e691591bbee0";
    sha256 = "0wd56wrqgjqda09pc153yv0d9084bg23v34i7fwr5pad4i6fsya3";
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
