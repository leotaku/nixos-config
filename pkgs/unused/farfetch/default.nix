{ fetchFromGitHub, stdenv, ...}:

stdenv.mkDerivation rec {
  name = "farfetch-${version}";
  version = "53e2466";

  src = fetchFromGitHub {
    owner = "Capuno";
    repo = "Farfetch";
    rev = "${version}";
    sha256 = "003xklzm65nd0p1g9a63s5kldv9fcmv2ga9gmn0cw4w6kk9kgawm";
  };

  postPatch = ''
    substitute ./Makefile ./Makefile \
    --replace "cp build/{settings.ini, *.ascii, *.txt} ~/.config/farfetch/" "" \
    --replace "mkdir -p ~/.config/farfetch/ ~/bin" "mkdir $out/bin; cp build/ff $out/bin/ff" \
    --replace "cp build/ff ~/bin/" "cp build/examples $out/etc -r" \
    --replace "@if" "#" 
  '';
	
}
