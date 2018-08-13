{ pkgs, fetchFromGitHub, python2Packages, ... }:

python2Packages.buildPythonApplication rec {
  name = "torrench-${version}";
  version = "master";

  src = fetchFromGitHub {
    owner = "ok100";
    repo = "lyvi";
    rev = "${version}";
    sha256 = "00rq73r5jyzvzlkx6ffc5h4i5z1yif6b5v5j1rdjabwx4g345038";
  };

  preConfigure = ''
    substitute ./setup.py ./setup.py \
      --replace "from pip" "#" \
      --replace "install_reqs" "#" \
      --replace "," ""

    '';

  propagatedBuildInputs = with pkgs; [ glyr ] ++ (with python2Packages; [ pip setuptools pillow urwid psutil dbus-python pygobject2 ]);

  #doCheck = false;
}
