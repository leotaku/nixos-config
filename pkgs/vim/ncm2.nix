{ fetchFromGitHub, vimUtils, pkgs, ... }:
{
  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "9470f96c53e897ac63fb08b72b05176de423081a";
      sha256 = "0h8q0yssn95lfp91vbk2ki7yb0rbp51f337ymy1n13xk160i41jv";
    };
  };
  
  nvim-yarp = vimUtils.buildVimPlugin {
    name = "nvim-yarp";
    src = fetchFromGitHub {
      owner = "roxma";
      repo = "nvim-yarp";
      rev = "5443ac06b3989baa9262adec810503e0234c316e";
      sha256 = "0b6gmsbgzgwidl0rpkwzr2l1qxd9aw5pvj8izflf6gz36r2irszq";
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
      rev = "d17deaceb3bc4da415cff25262762c99cdd34116";
      sha256 = "16pbln1k6jw5yc79g7g736kf4m7hn6kdlsphml7dla7xnnzd2az3";
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
