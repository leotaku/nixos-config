with import <nixpkgs> {};

python36.withPackages (ps: with ps; [ numpy toolz matplotlib pylint jupyter notebook ])
