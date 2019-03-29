{ pkgs, fetchFromGitHub, python3Packages, ... }:

python3Packages.buildPythonApplication rec {
  name = "torrench-${version}";
  version = "2018-04-11";

  src = fetchFromGitHub {
    owner = "kryptxy";
    repo = "torrench";
    rev = "2c4869ebc48012531689830351159da7b3f104b5";
    sha256 = "0lz976im6ssvr5qlrm807md3h0sglx7chd61jry4vr67dg7g0248";
  };

  propagatedBuildInputs = with pkgs; with python3Packages; [ configparser tabulate beautifulsoup4 lxml requests colorama pyperclip xclip ];

  doCheck = false;
}
