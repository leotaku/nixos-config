{ fetchFromGitHub, vimUtils, pkgs, ... }:
{
  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "f962aa0";
      sha256 = "1swca2iyfwn90h3advgzb5ipwqpxg8r4r0qc7ryik2k2awapnjgf";
    };
  };
  
  nvim-yarp = vimUtils.buildVimPlugin {
    name = "nvim-yarp";
    src = fetchFromGitHub {
      owner = "roxma";
      repo = "nvim-yarp";
      rev = "52317ce";
      sha256 = "1xj1n9x1nxjbbpp29x5kkwr0bxziwzn8n2b8z9467hj9w646zyrj";
    };
  };

  ncm2-ultisnips = vimUtils.buildVimPlugin {
    name = "ncm2-ultisnips";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-ultisnips";
      rev = "15432d7";
      sha256 = "0ixajh08fd5dgdz4h1sdxgiaind1nksk1d4lwyb6n4ijf672pms2";
    };
  };

  ncm2-racer = vimUtils.buildVimPlugin {
    name = "ncm2-racer";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-racer";
      rev = "e3aec08";
      sha256 = "03vd252qm6b3isd45jz7wah3p9sm73pf4gxngwsfb1hc1hn7c1cf";
    };
  };
  
  ncm2-path = vimUtils.buildVimPlugin {
    name = "ncm2-path";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-path";
      rev = "875ae47";
      sha256 = "09vhggrb1nigr8p53gd9ibn3b84dh9yix2ndj2453wnq8ny9x2dc";
    };
  };
  
  ncm2-syntax = vimUtils.buildVimPlugin {
    name = "ncm2-syntax";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-syntax";
      rev = "8007abf";
      sha256 = "0w7gxy96cnvsx4qy7saan7sk7hmmpsn06qyhx72svjx8h78kz0ac";
    };
  };
  
  ncm2-bufword = vimUtils.buildVimPlugin {
    name = "ncm2-bufword";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-bufword";
      rev = "86a92eb";
      sha256 = "02f43rr9apgcjpz4ipnin4v3cvdlx931a0787x87iyr8a0aljg3y";
    };
  };

  ncm2-tmux = vimUtils.buildVimPlugin {
    name = "ncm2-tmux";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-tmux";
      rev = "4f60ee1";
      sha256 = "1ihbm65b9bc0y068w6r0k8f9lsc3603npb55chcchpj7z75539yh";
    };
  };
}
