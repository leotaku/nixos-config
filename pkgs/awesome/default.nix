{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "413d47d5a5b6b9d72b6ea01839601efb092ec583";
    sha256 = "11yqh6bs53sa5na5aiwn6v3i765kayln9p13ni27l4xna64v366z";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
