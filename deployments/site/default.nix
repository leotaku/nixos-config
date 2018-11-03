{ stdenv, ... }:
stdenv.mkDerivation {
  name = "website";
  src = ./src;

  installPhase = ''
  mkdir $out
  cp -r ./* $out
  '';
}


# { stdenv, multimarkdown, ... }:
# stdenv.mkDerivation {
#   name = "website";
#   src = ./src;
#   nativeBuildInputs = [ multimarkdown ];
# 
#   buildPhase = ''
#   multimarkdown site.md > index.html
#   '';
# 
#   installPhase = ''
#   mkdir $out
#   cp -r ./* $out
#   '';
# }

# { stdenv, pandoc, ... }:
# stdenv.mkDerivation {
#   name = "website";
#   src = ./src;
#   depsBuildBuild = [ pandoc ];
# 
#   buildPhase = ''
#   make OUTDIR=out
#   '';
# 
#   installPhase = ''
#   cp -r ./out $out
#   '';
# }
