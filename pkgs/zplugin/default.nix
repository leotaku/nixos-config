{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-01-15";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "4201a98162829965644ab1bcdddab8ef2efb6169";
    sha256 = "12ivjy484rryyas58idnxjdvvd2swpb2f6aj6lx9mm6k0wlz68kb";
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
