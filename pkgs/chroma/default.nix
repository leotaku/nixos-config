{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-06-12";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "57c1bd941c39be8b5cebedb6b7c4bcedc7c801b7";
    sha256 = "1pbkj434hbkr0fv2q8mgpjnzfl56zigzzznm41h6gf4ck41hmjbx";
  };

  subPackages = [ "./cmd/chroma" ];

  vendorSha256 = "16cnc4scgkx8jan81ymha2q1kidm6hzsnip5mmgbxpqcc2h7hv9m";

  meta = with lib; {
    description = "A general purpose syntax highlighter in pure Go";
    homepage = "https://github.com/alecthomas/chroma";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
