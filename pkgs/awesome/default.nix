{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "e6f5c7980862b7c3ec6c50c643b15ff2249310cc";
    sha256 = "1wpiz7dzcsah0bgjsplvvaxx74yl7h4dhxcifzb91s7wjsxy5yv9";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
