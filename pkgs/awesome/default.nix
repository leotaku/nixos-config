{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "7451c6952e0a24bd54edc0f7ecff6ad46ef65dcb";
    sha256 = "17w7n3s34482hzs9692f9wwwcl96drhg860mmj2ngzlxp3p5lv76";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
