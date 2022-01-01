{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "21b908bef9043c8fe80e0f98c9460991f37b3d10";
    sha256 = "1kwhjxyipmswzc6ybb3shv4z5rf4lb6l18b8v5ppcjc74l1wymy6";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
