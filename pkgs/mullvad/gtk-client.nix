{ pkgs, fetchurl, pythonPackages, ... }:

pythonPackages.buildPythonApplication rec {
  pname = "mullvad-gtk";
  version = "67";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://www.mullvad.net/media/client/mullvad-67.tar.gz";
    sha256 = "1ha8m5rqlfcx06jqmzsnbqwsvh462vlcz5hjsnkgaadzin8fvy16";
  };

  propagatedBuildInputs = with pkgs; with pythonPackages; [ openvpn openresolv wxPython30 appdirs psutil netifaces ipaddr nettools ];
  buildInputs = with pkgs; [ polkit ];
}
