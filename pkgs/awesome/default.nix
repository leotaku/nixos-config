{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "0e5fc4575ab0adbae75908cb49937d9cf63437ec";
    sha256 = "0zkqn5ni4iqwfxyilcnp78l0xan7ksvk1q71wqh1i2fh5hmxhn34";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
