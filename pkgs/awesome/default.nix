{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "edf21742b8703b2339ea85c040b0576c3b234ed1";
    sha256 = "0zjg8mkr8w41z89avlkp68zj7c58sydwpdb8qhg2dp0yrkgj9amj";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
