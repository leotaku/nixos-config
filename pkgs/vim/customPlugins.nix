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
      owner = "LeOtaku";
      repo = "vim-slime";
      rev = "6f05a53";
      sha256 = "0sd2kcndzf1l3w6gvjhyfj7al4ryxsmlcjq80nda6888f1vximcf";
    };
  }; 

  vim-sexp = pkgs.vimUtils.buildVimPlugin {
    name = "vim-sexp";
    src = pkgs.fetchFromGitHub {
      owner = "guns";
      repo = "vim-sexp";
      rev = "1229294";
      sha256 = "1mfqbmrbqgnsc34pmcsrc0c5zvgxhhnw4hx4g5wbssfk1ddyx6y0";
    };
  }; 
  
  vim-express = pkgs.vimUtils.buildVimPlugin {
    name = "vim-express";
    src = pkgs.fetchFromGitHub {
      owner = "tommcdo";
      repo = "vim-express";
      rev = "2cbe706";
      sha256 = "0fcwykwp6dwcs7jkkcxx5g9v9g9csj178c07sl3lcvmgidms79qk";
    };
  };

  parinfer-rust = 
  let
  parinfer-rust-package = pkgs.rustPlatform.buildRustPackage rec {
    name = "parinfer-rust-${version}";
    version = "a26808b";

    src = ./parinfer;
    cargoSha256 = "07dmalpnikrzvx9rg2dziijjhrnw8z2pxv3im6vsj458dydzkwri";

    doCheck = false;  
  };
  in
  pkgs.vimUtils.buildVimPlugin rec {
      name = "parinfer-rust";
      version = "a26808b";

      src = ./parinfer;
      postBuild = ''
        mkdir -p ./target/release
        cp ${parinfer-rust-package}/bin/libparinfer_rust.so target/release
      '';
    };

  }
