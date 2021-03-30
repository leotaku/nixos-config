{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "95558ac919794d810f095996b693336dcd0a58bb";
    sha256 = "0xhmrybijaypigwh2s6wlsy9b73hvamd08bpph8jqh2divqwygz1";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
