{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "832483dd60ba194f3ae0200ab39a3a548c26e910";
    sha256 = "1bcbxsiydlz439af6dq69z8g7rca4jganlz65f3ajrlgqknk86cq";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
