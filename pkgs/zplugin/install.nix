{ writeShellScriptBin, callPackage }:

writeShellScriptBin "zplugin-install" ''
  echo "${callPackage ./default.nix {}}"
''
