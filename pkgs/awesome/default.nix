{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "cc67a5b40bcd461a3ed3e955da8409219b11efcf";
    sha256 = "15cas610psik838rnqdj306g8ys69i96q3c8cda384yvk9i979s7";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
