{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-01-05";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "a8eff1b932b62cdbdd8da7fb843bfd64e2da5a8b";
    sha256 = "0iyfwq6ngi60h91pr76ap6ma8jv9frckjx5czbi6x3dacbiplv88";
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
