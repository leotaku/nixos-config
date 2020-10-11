{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "9e67481ee914fe753812e56fc39c21972ff31e6a";
    sha256 = "1hck0cvrqkh0z4vjj3naawhh9n7l57xjs4j1bpgaz21ja2ihyq61";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
