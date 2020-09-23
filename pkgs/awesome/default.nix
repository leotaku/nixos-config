{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "7a759432d3100ff6870e0b2b427e3352bf17c7cc";
    sha256 = "0kjndz8q1cagmybsc0cdw97c9ydldahrlv140bfvl1xzhhbmx0hg";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
