{ pkgs, ... }: 

{
  vim-instant-markdown = pkgs.vimUtils.buildVimPlugin {
    name = "vim-instant-markdown";
    src = pkgs.fetchFromGitHub {
      owner = "suan";
      repo = "vim-instant-markdown";
      rev = "master";
      sha256 = "10zfm1isqv1mgx8598bfghf2zwzxgba74k0h658lnw59inwz7dkr";
    };
  };

  vim-surround = pkgs.vimUtils.buildVimPlugin {
    name = "vim-surround";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-surround";
      rev = "v2.1";
      sha256 = "0pcs8f6cv7k6wi7krah025gax3ms23fgflg2cr3fq9fpssrlf1ws";
    };
  };

  vim-rmarkdown = pkgs.vimUtils.buildVimPlugin {
    name = "vim-surround";
    src = pkgs.fetchFromGitHub {
      owner = "vim-pandoc";
      repo = "vim-rmarkdown";
      rev = "3de5ed4";
      sha256 = "1ccwdhc7fi4sryssl00p02msqbqzr0674x5hcyir6a4h8w8hic68";
    };
  };
  
  conque = pkgs.vimUtils.buildVimPlugin {
    name = "conque";
    src = pkgs.fetchFromGitHub {
      owner = "vim-scripts";
      repo = "Conque-Shell";
      rev = "202";
      sha256 = "09c63fnby8nnawg1psp0nbkphw9s7vrdj2wrf2ixlpiv357x478i";
    };
  };

  vim-tutor-mode = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tutor-mode";
    src = pkgs.fetchFromGitHub {
      owner = "fmoralesc";
      repo = "vim-tutor-mode";
      rev = "0.2.1";
      sha256 = "0jz1471pw0s7hbwdr34zbkafrxsp31hpjz7vxil688advr13mqc6";
    };
  };

  base16-vim = pkgs.vimUtils.buildVimPlugin {
    name = "base16-vim";
    src = pkgs.fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-vim";
      rev = "7959654";
      sha256 = "0v579vr8z59g0vxsar1byfhgdvlw8yx1spazjfm2hp110nf6icn1";
    };
  };

  disco = pkgs.vimUtils.buildVimPlugin {
    name = "disco";
    src = pkgs.fetchFromGitHub {
      owner = "jsit";
      repo = "disco.vim";
      rev = "84d4560";
      sha256 = "0kxm52pmjd80916k8d33ddvqwhx0sc3vkks5i05g6kirgy34lsqx";
    };
  };
  
  slimv = pkgs.vimUtils.buildVimPlugin {
    name = "slimv";
    src = pkgs.fetchFromGitHub {
      owner = "kovisoft";
      repo = "slimv";
      rev = "f781a76";
      sha256 = "1076lv3jiz29inlsvv012jd5fb7462cscii0gk8pvzgiik74bm4a";
    };
  };

  vim-sneak = pkgs.vimUtils.buildVimPlugin {
    name = "vim-sneak";
    src = pkgs.fetchFromGitHub {
      owner = "justinmk";
      repo = "vim-sneak";
      rev = "943e084";
      sha256 = "0b2h2rvfyn44zxg88037qjrwi7g86xzshn4kiicrzhx0lxx05102";
    };

    prePatch = ''
    rm ./Makefile
    '';
  };

 vim-slime = pkgs.vimUtils.buildVimPlugin {
    name = "vim-slime";
    src = pkgs.fetchFromGitHub {
      owner = "jpalardy";
      repo = "vim-slime";
      rev = "e58486b";
      sha256 = "1abp1wh10wdvrii1jyzg12a0c5jk2yf88mczxkjwql0r7wcn89qd";
    };
  }; 

  # Broken:
  parinfer-rust-vim = pkgs.vimUtils.buildVimPlugin rec {
      name = "parinfer-rust-vim";
      version = "a26808b";

      src = pkgs.fetchFromGitHub {
      };
    };

    parinfer-rust-package = pkgs.rustPlatform.buildRustPackage rec {
      name = "parinfer-rust-${version}";
      version = "a26808b";

      src = pkgs.fetchFromGitHub {
        owner = "eraserhd";
        repo = "parinfer-rust";
        rev = "${version}";
        sha256 = "1j47ypk6waphp4lr5bihdv87945i2gs6d207szcqgph7igg92s8a";
      };

      cargoSha256 = "1q68qyl2h6i0qsz82z840myxlnjay8p1w5z7hfyr8fqp8wgwa7cx";

    };
}
