{ pkgs ? (import <nixpkgs> {})}:
let
srcs = {
  impala = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-18.03";
    sha256 = "000nk8qnf158viwfg06dqwdam98v7a3fj834q548jjz0pw4pbpns";
  };
  jellyfish = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-18.09";
    sha256 = "011fnvwiag8sjmr6mm71zcpnknndj3lxqzq0wa0b1xqgkxw957a8";
  };
  master = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "master";
    sha256 = "1gn8ggil7fa7blwpynf6vwvxapa5nk28wq2kzm1p6951bw68m9av";
  };
};
in
{
  impala = (import srcs.impala {});
  jellyfish = (import srcs.jellyfish {});
  master = (import srcs.master {});
}
