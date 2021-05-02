{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "a4572b9b52d89369ce3bd462904d536ec116dc35";
    sha256 = "1kj2qz2ns0jn5gha4ryr8w8vvy23s3bb5z3vjhwwfnrv7ypb40iz";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
