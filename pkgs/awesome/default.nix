{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "eddabebac46d94b5afd2916460f22b2057628b2b";
    sha256 = "1ylfqw5pvlgda7qj49izkzn2i7igl54i73qxnks0fxw2w5ji1pwp";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
