{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "bd776c98015767e156556e6651da4241b657d5bb";
    sha256 = "102ql09pz041n6p68h6d0wlf2vw0619p18v1qwwmr62yh4scpkxs";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
