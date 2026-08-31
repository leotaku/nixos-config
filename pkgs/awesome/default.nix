{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "0a5e50cf7ee214fae47159e0e976ab4a78d2ed4f";
    sha256 = "1cakzxv79wzd7y49zfgzrnbkwxx039c0a0ghhnylg92bfy6gai8r";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
