{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "ed6cdf87b1b70b4eb9bdfd33791e920e79e8f5e5";
    sha256 = "1d4xj2a303jaj8zg6j5kmnvqmb9x7gm4vs4k3rv9h6lb30kyx5l5";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
