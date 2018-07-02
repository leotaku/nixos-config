{ fetchFromGitHub, stdenv, libxcb, libXrandr, xcbutilwm, xcbutilkeysyms, xproto, ...}:

stdenv.mkDerivation rec {
  name = "howm-${version}";
  version = "master";

  src = fetchFromGitHub {
    owner = "HarveyHunt";
    repo = "howm";
    rev = "${version}";
    sha256 = "1pnmmf7sm237ygxmicl3f96k4fias0f28xssmr4nxbc07gv91521";
  };

  preInstall = ''
  substitute ./Makefile ./Makefile --replace "/bin" ""
  '';
  
  makeFlags = [ "DESTDIR=./" "INSTALL_PREFIX=bin" "XSESSION_PREFIX=share" ];

  postInstall = ''
  mkdir $out/bin
  mv bin/release/howm $out/bin/howm
  mv share $out
  '';

  buildInputs = [
    libxcb libXrandr xcbutilwm xcbutilkeysyms xproto
  ];
}
