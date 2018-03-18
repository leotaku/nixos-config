{ pkgs, fetchhg, stdenv, bundlerEnv, ruby, ... }:

let
  gems = bundlerEnv {
    name = "ruby-env";
    inherit ruby;
    gemdir = ./.;
  };
in
stdenv.mkDerivation rec {
  name = "subtle-${version}";
  version = "0.11";

  src = fetchhg {
    url = "http://hg.subforge.org/subtle";
    rev = "0.11";
    sha256 = "16bwp04ylvrhz34zi69h3qzwrhx9qqmqlwl63d4c7byc4xwpk036";
  };

  patchPhase = ''
  substitute ./Rakefile ./Rakefile \
    --replace "fail(\"Ruby 1.9.0 or higher required\")" "" \
    --replace "-Wall" "" \
    --replace "sitelibdir" "vendorlibdir"
  substitute ./data/subtler/runner.rb ./data/subtler/runner.rb \
    --replace "subtle/subtlext" "subtlee/subtwext"
  '';
  buildInputs = with pkgs; [  ];
  propagatedBuildInputs = with pkgs; [ pkgconfig gems gems.wrappedRuby xorg.libXrandr xorg.libXft xorg.libXpm xorg.libXinerama xorg.libXtst ];
  buildPhase = ''
  rake default xtest=false debug=yes destdir=$out prefix= extdir=$out/ext
  '';
  installPhase = "rake install";

  doCheck = false;
}
