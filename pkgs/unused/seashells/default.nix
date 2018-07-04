{ pkgs, pythonPackages, ... }:

pythonPackages.buildPythonApplication rec {
  pname = "seashells";
  version = "0.1.2";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0cw4yrfydx7spb33mdmvk5b66ygnrzs9lp0lmy1wszxva3q3c6s4";
  };

  propagatedBuildInputs = with pkgs; with pythonPackages; [ ];
  buildInputs = with pkgs; [ ];
} 
