{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "50b9b1043716c9ff0e27ab862112b0ee6821fc16";
    sha256 = "0a2cwbaaylka5dpnlz73yxnbaign3xwgp4sk7dn3bwg3nzakis20";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
