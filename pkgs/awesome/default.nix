{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "b54e50ad6cfdcd864a21970b31378f7c64adf3f4";
    sha256 = "1cd1jirhndss583agxrapq9wf6q7m27gv95wdmx4bbzrykac4df8";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
