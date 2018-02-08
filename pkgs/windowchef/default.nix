{ fetchFromGitHub, stdenv, libxcb, libXrandr, xcbutilwm, xcbutilkeysyms, xproto, ...}:

stdenv.mkDerivation rec {
  name = "windowchef-${version}";
  version = "v0.4.1";

  src = fetchFromGitHub {
    owner = "tudurom";
    repo = "windowchef";
    rev = "${version}";
    sha256 = "1dfmmcs1w56a4a88bn0776c6hcilxwbi96pmbpikfrx297h99ygr";
  };

  postPatch = "
  substitute ./config.mk ./config.mk --replace /usr/local $out
  ";
  buildInputs = [
    libxcb libXrandr xcbutilwm xcbutilkeysyms xproto
  ];
}
