{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "b7bac1dc761f7e231355e76351500a97b27b6803";
    sha256 = "0140429rlfpfnjz6rviy8s5s7x7pyrs3mmbx0qplkfww0ilrs72b";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
  patches = [ ];
})
