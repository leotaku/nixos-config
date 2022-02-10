{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "86b6c49a0ff758d1792db64aa852159386f2fcdc";
    sha256 = "0bz3yxhawjzgi1dizqiry6hfgvzmqiqjx1an971bacvxfqig1ibl";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
