{ awesome, fetchFromGitHub }:
let
  src = fetchFromGitHub {
    owner = "awesomeWM";
    repo = "awesome";
    rev = "29c0057795efcd52616e97a8f61c98a4660ae2af";
    sha256 = "049c4cka721y3b8i1kfp0hshf632walbwsfc36l3rg39zhhbk0nr";
  };
in
(awesome.override {
  gtk3Support = true;
}).overrideAttrs (oldAttrs: {
  inherit src;
  patches = [ ];
})
