{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "aa8c7c6e27a20fa265d3f06c5dc3fe72cc5f021e";
    sha256 = "18bxn9z8g098ql4vc9wsqxmjj6h32y36fa7iyi7w9wif3sc0hq0c";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
