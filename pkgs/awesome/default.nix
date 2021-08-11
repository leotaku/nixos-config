{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "8a81745d4d0466c0d4b346762a80e4f566c83461";
    sha256 = "031x69nfvg03snkn7392whg3j43ccg46h6fbdcqj3nxqidgkcf76";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
