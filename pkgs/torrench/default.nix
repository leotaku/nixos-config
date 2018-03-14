{ pkgs, fetchFromGitHub, python3Packages, ... }:

python3Packages.buildPythonApplication rec {
  name = "torrench-${version}";
  version = "v1.0.61";

  src = fetchFromGitHub {
    owner = "kryptxy";
    repo = "torrench";
    rev = "${version}";
    sha256 = "1aqwrka5h1chbl93985z6pad8yb1blglfyk6xciwyn80h3g3zv3s";
  };

  propagatedBuildInputs = with pkgs; with python3Packages; [ configparser tabulate beautifulsoup4 lxml requests colorama pyperclip xclip ];

  doCheck = false;
}
