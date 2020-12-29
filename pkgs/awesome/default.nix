{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "66b1780d85c5e2e2c7a5b0345b0f9cd84681b3a1";
    sha256 = "107mjqkmylkrkc8cm3k9jcrjgqyamv9q6ghw4pyh3hcq3nb672yr";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
