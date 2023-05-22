{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "485661b706752212dac35e91bb24a0e16a677b70";
    sha256 = "0kp70wa5hy5v6zrn3g3d7n5idnwbgp1s3xnfz6ixnwzw8lmnlhiv";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
