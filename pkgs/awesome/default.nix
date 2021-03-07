{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "aba1cf398ff9203b5fcdc770e14a6646d67a0585";
    sha256 = "10xk9cayg6azvzk9aqid1hj5r89a3mlhlx5h3wpmqfm0hk2zfvgv";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
