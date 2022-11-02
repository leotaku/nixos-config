{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "5077c8381b6bf7fb8215d24d1f0c683816e27a55";
    sha256 = "0m7iwn9sm8ajh448ghdh2b6pabmqfm1vfv2b8jmnj5hcr4qs7wf1";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
