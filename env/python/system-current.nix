{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
pkgs.python3.buildEnv.override {
  extraLibs = with pkgs.python3Packages; [
    sh
    numpy 
    pandas 
    toolz 
    matplotlib 
    jupyter 
    notebook 
    flake8 
    jedi 
  ];
  ignoreCollisions = true;
}
