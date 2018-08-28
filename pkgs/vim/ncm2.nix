{ fetchFromGitHub, vimUtils, pkgs, ... }:
{
  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "f962aa074a3bf4e7526beca21442e03987829d43";
      sha256 = "1swca2iyfwn90h3advgzb5ipwqpxg8r4r0qc7ryik2k2awapnjgf";
    };
  };
  
  nvim-yarp = vimUtils.buildVimPlugin {
    name = "nvim-yarp";
    src = fetchFromGitHub {
      owner = "roxma";
      repo = "nvim-yarp";
      rev = "52317ced0e16f226f0d44878917d0b5f4657b4d4";
      sha256 = "1xj1n9x1nxjbbpp29x5kkwr0bxziwzn8n2b8z9467hj9w646zyrj";
    };
  };

  ncm2-ultisnips = vimUtils.buildVimPlugin {
    name = "ncm2-ultisnips";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-ultisnips";
      rev = "15432d7933cfb855599442a67d6f39ddb706c737";
      sha256 = "0ixajh08fd5dgdz4h1sdxgiaind1nksk1d4lwyb6n4ijf672pms2";
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
      rev = "875ae47e171abc2ba6710bb835727bed46d7b329";
      sha256 = "09vhggrb1nigr8p53gd9ibn3b84dh9yix2ndj2453wnq8ny9x2dc";
    };
  };
  
  ncm2-syntax = vimUtils.buildVimPlugin {
    name = "ncm2-syntax";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-syntax";
      rev = "b13180a39ec1be77d19ece47ed91deed9fca200b";
      sha256 = "1rlycny5mivli02nnn8874pmr82qad393i4mrb08iqf8zrczvxd5";
    };
  };
  
  ncm2-bufword = vimUtils.buildVimPlugin {
    name = "ncm2-bufword";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-bufword";
      rev = "86a92eb3fb217f9ea1e93f890b7e5e0eb1671ca9";
      sha256 = "02f43rr9apgcjpz4ipnin4v3cvdlx931a0787x87iyr8a0aljg3y";
    };
  };

  ncm2-tmux = vimUtils.buildVimPlugin {
    name = "ncm2-tmux";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-tmux";
      rev = "4f60ee1be57531295075d808e0006c83894096d1";
      sha256 = "1ihbm65b9bc0y068w6r0k8f9lsc3603npb55chcchpj7z75539yh";
    };
  };
}
