{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "4319b161103a81403ba3516924e86e13ff33c036";
    sha256 = "1p7c3cmdy0iyk28fgc579rkzfhnwn1i1b541rs2nw80h1xzs1g80";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
})
