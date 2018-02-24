with import <nixpkgs> {};

let
  version = "19e8039";
  #  "5c97946";
in
ranger.overrideAttrs (old: {
  name = "ranger-${version}";
  src = fetchFromGitHub {
    owner = "mark-dawn";
    repo = "ranger";
    rev = "${version}";
    sha256 = "1a9w0g238kdw6ml6wklgwjckrsx1snxk72gbimcdzmcila9wmrx4";
    #"1h85wg6lxz7pp7qc5h513b2hb0hmcdvhyydid72c7hjrrwq7pdkc";
  };
  propagatedBuildInputs = [ file pythonPackages.pillow ];
})
