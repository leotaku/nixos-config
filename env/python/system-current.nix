with import <nixpkgs> {};
python3.withPackages (ps: with ps; [ numpy toolz matplotlib pylint jupyter notebook ])
