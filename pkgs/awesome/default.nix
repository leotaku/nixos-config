{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "f009815cb75139acf4d8ba3c1090bf2844d13f4c";
    sha256 = "0jrwgsdwkav5sxic1gl5n8kw4w0lhgw5lnpppj8xl5dysxj4w3jg";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
