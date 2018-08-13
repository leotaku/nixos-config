{ bundlerApp }:

bundlerApp {
  pname = "vmail";
  gemdir = ./.;
  exes = [ "vmail" ];
}
