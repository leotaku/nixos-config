{ python3Packages, lib, ... }:
with python3Packages;
{
  nixos = buildPythonApplication rec {
    pname = "nixos-cli";
    version = "0.1";

    src = ./src;

    propagatedBuildInputs = [ setuptools pyyaml GitPython click ];

    doCheck = false;
  };
}
