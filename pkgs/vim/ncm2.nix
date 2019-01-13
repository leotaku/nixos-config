{ fetchFromGitHub, vimUtils, pkgs, ... }:
{
  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "ec1b0c917d1b2086bff1b67b86ff54cfaf4aadd0";
      sha256 = "18nbr7d7y60l87q8rc4r85ngknbf1x5q5zmnxicxh6xrkl1hmf58";
    };
  };
  
  nvim-yarp = vimUtils.buildVimPlugin {
    name = "nvim-yarp";
    src = fetchFromGitHub {
      owner = "roxma";
      repo = "nvim-yarp";
      rev = "1524cf7988d1e1ed7475ead3654987f64943a1f0";
      sha256 = "1iblb9hy4svbabhkid1qh7v085dkpq7dwg4aj38d8xvhj9b7mf6v";
    };
  };

  ncm2-ultisnips = vimUtils.buildVimPlugin {
    name = "ncm2-ultisnips";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-ultisnips";
      rev = "304f0c6d911991a1c6dbcba4de12e55a029a02c7";
      sha256 = "1ny3fazx70853zdw5nj7yjqwjj7ggb7f6hh2nym6ks9dmfpfp486";
    };
  };

  ncm2-racer = vimUtils.buildVimPlugin {
    name = "ncm2-racer";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-racer";
      rev = "e3aec0836ea1ff1b820e937f9c6463eb015fa784";
      sha256 = "03vd252qm6b3isd45jz7wah3p9sm73pf4gxngwsfb1hc1hn7c1cf";
    };
  };
  
  ncm2-path = vimUtils.buildVimPlugin {
    name = "ncm2-path";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-path";
      rev = "d17deaceb3bc4da415cff25262762c99cdd34116";
      sha256 = "16pbln1k6jw5yc79g7g736kf4m7hn6kdlsphml7dla7xnnzd2az3";
    };
  };
  
  ncm2-syntax = vimUtils.buildVimPlugin {
    name = "ncm2-syntax";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-syntax";
      rev = "7cd3857001a219be4bc7593b7378034b462415e4";
      sha256 = "0l36qvsclhg8vr1ix1kpdl0kh739gp6b7s03f18vf9f0aj0im6w2";
    };
  };
  
  ncm2-bufword = vimUtils.buildVimPlugin {
    name = "ncm2-bufword";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-bufword";
      rev = "183843100999d021e5d52c09c61faa6c64ac6e2f";
      sha256 = "11ma0wfzxjd0mv1ykxjwqk9ixlr6grpkk1md85flqqdngnyif6di";
    };
  };

  ncm2-tmux = vimUtils.buildVimPlugin {
    name = "ncm2-tmux";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-tmux";
      rev = "196131f285f05966bdd1126d6bd0c912d01b92c5";
      sha256 = "0i9j9yn7ayisl3rwawjic7g3a07cg2541zh3jangjd9wz271l69r";
    };
  };
}
