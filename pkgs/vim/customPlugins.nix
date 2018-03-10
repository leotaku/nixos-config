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

}
