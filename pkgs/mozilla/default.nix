self: super:
let
  src = self.fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "57c8084c7ef41366993909c20491e359bbb90f54";
    sha256 = "0lchhjys1jj8fdiisd2718sqd63ys7jrj6hq6iq9l1gxj3mz2w81";
  };
in (import src) self super
