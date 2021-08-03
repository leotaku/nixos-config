{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "4b494952da8ba8db9078c27500127d7e54d67cd8";
    sha256 = "1ikilnjrxjjz979z7i4csd98z0ysdcls2sn1hfz3nq278zsnqn18";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
