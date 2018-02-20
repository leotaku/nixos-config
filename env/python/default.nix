with import <nixpkgs> {};

python35.withPackages (ps: with ps; [ numpy toolz matplotlib pylint ])
