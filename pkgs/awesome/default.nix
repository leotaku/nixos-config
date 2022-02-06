{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "2d6244f9445ffa22c8d53b3e4b4641e0e5bb6170";
    sha256 = "0sdymkcazi5igljw993hk5cqwwfqb7wc2ix2zayp9b2m2ayggqb7";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
