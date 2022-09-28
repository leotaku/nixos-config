{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "4a140ea5ea681e7a0f62d8ef050b0ed1b905cc68";
    sha256 = "0hrfwilgd4vxhqd0hz88hq3j2rizhdlr7g0cq9q8ic0m8z47q1rq";
  };
in (awesome.override { gtk3Support = true; }).overrideAttrs (oldAttrs: {
  inherit src;
  cmakeFlags = oldAttrs.cmakeFlags
    ++ [ "-DGENERATE_MANPAGES=OFF" "-DGENERATE_DOC=OFF" ];
  patches = [ ];
})
