{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "392dbc21ab6bae98c5bab8db17b7fa7495b1e6a5";
    sha256 = "093zapjm1z33sr7rp895kplw91qb8lq74qwc0x1ljz28xfsbp496";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
