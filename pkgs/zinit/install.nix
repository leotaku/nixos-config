{ writeShellScriptBin, callPackage }:

writeShellScriptBin "zinit-install" ''
  echo "${callPackage ./default.nix {}}"
''
