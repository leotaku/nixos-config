{ callPackage, vimUtils, fetchFromGitHub, pkgs, ... }: 

{
  TagHighlight = 
  let 
    version = "05449e727b55";
  in
  vimUtils.buildVimPlugin {
    name = "TagHighlight";
    src = pkgs.fetchhg {
      url = "https://bitbucket.org/abudden/taghighlight/get/${version}.zip";
      sha256 = "0ch6nhvsw2jblcf06hrs8kkrqkqnh0rh3ln968wxc9gfdphf657y";
    };
  };

  winresizer = vimUtils.buildVimPlugin {
    name = "winresizer";
    src = fetchFromGitHub {
      owner = "simeji";
      repo = "winresizer";
      rev = "e914728083536102c81281a2b2d0b81eec1e6bfb";
      sha256 = "04ysqp630fjhnnasrzv5ngkz0lqbf1dpmbrzp1nh52p52rz4v768";
    };
  };

  CamelCaseMotion = vimUtils.buildVimPlugin {
    name = "CamelCaseMotion";
    src = fetchFromGitHub {
      owner = "bkad";
      repo = "CamelCaseMotion";
      rev = "e2816c75c3b73f176af3e94576793b342976f0a1";
      sha256 = "1g9hl6rxabbijs8hp53ra08iqgbc34bv4sbifkcjkjdr3r6fikas";
    };
  };
  
  vim-delve = vimUtils.buildVimPlugin {
    name = "vim-delve";
    src = fetchFromGitHub {
      owner = "sebdah";
      repo = "vim-delve";
      rev = "2f2a61e3649bc63a53a50f17e23b265e666c5a16";
      sha256 = "15wz19ar2agnkiznawywfps3ia8syv7c2c9f0h5ycd2r1bij1l8s";
    };
  };

  Mundo = vimUtils.buildVimPlugin {
    name = "Mundo";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "2540b4fa4914f0b2433d07eb510f83555ce7a136";
      sha256 = "0a5qxfsvrw7y6s00dfxhn9b2xr0h55wsx2cpl54havjwqcr5fs1s";
    };
  };

  vim-instant-markdown = vimUtils.buildVimPlugin {
    name = "vim-instant-markdown";
    src = fetchFromGitHub {
      owner = "suan";
      repo = "vim-instant-markdown";
      rev = "5f592bdb0288710205176f189c3203fd40a6ee2e";
      sha256 = "10zfm1isqv1mgx8598bfghf2zwzxgba74k0h658lnw59inwz7dkr";
    };
  };

  endwise = vimUtils.buildVimPlugin {
    name = "endwise";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-endwise";
      rev = "f41ebc27b7042760c7812da9f33d5167b33a874e";
      sha256 = "046kkfyc9brdwd2kpgr6hw2cxv1xbffx6j2rwg8msk7lvyvga1aq";
    };
  };

  vim-autoswap = vimUtils.buildVimPlugin {
    name = "vim-autoswap";
    src = fetchFromGitHub {
      owner = "gioele";
      repo = "vim-autoswap";
      rev = "a492e0c0f7f0306a5ad2cfea29d64c4cd7a508eb";
      sha256 = "1049m6nwwy5kb01gvrkan6hrszm0hri2gix0arnf905jwkiijbz4";
    };
  };

  vim-rmarkdown = vimUtils.buildVimPlugin {
    name = "vim-surround";
    src = fetchFromGitHub {
      owner = "vim-pandoc";
      repo = "vim-rmarkdown";
      rev = "2049f7f400be59d475b9bf8f613beb3fecdd964c";
      sha256 = "1h7ca1qycavdfs81p4yyc2vihfyfys3k3z6y0148a17bkvhxhyvb";
    };
  };
  
  conque = vimUtils.buildVimPlugin {
    name = "conque";
    src = fetchFromGitHub {
      owner = "vim-scripts";
      repo = "Conque-Shell";
      rev = "f3c92a29a162045c2604212f51846f0d7f73d661";
      sha256 = "12iynwkdvmzjzpkdd2dkjzsz7yxzwfyhd5q3g5aak1cygqb07rkv";
    };
  };

  vim-minimap = vimUtils.buildVimPlugin {
    name = "vim-minimap";
    src = fetchFromGitHub {
      owner = "severin-lemaignan";
      repo = "vim-minimap";
      rev = "1bc36a0ff307e33e5d96ee58999b099aa41ac9d6";
      sha256 = "0x89im2w86q8fkhhw0yrvc0ih4b10518kmk7q0ck7d7dczy7qzyn";
    };
  };

  vim-tutor-mode = vimUtils.buildVimPlugin {
    name = "vim-tutor-mode";
    src = fetchFromGitHub {
      owner = "fmoralesc";
      repo = "vim-tutor-mode";
      rev = "840df3dd3cf81808c00fdb28af26f9436cad06a3";
      sha256 = "0qpw0i8mmdkpqx210dbk0rj785r4a2za9xnrkgn12kyscn70386i";
    };
  };

  base16-vim = vimUtils.buildVimPlugin {
    name = "base16-vim";
    src = fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-vim";
      rev = "fcce6bce6a2f4b14eea7ea388031c0aa65e4b67d";
      sha256 = "0wi8k80v2brmxqbkk0lrvl4v2sslkjfwpvflm55b3n0ii8qy39nk";
    };
  };

  disco = vimUtils.buildVimPlugin {
    name = "disco";
    src = fetchFromGitHub {
      owner = "jsit";
      repo = "disco.vim";
      rev = "f8f4549a845798e13a606f82f5d1456ce3900471";
      sha256 = "1inz64ziaj45wv917ajhmw108sz7ch33mfncfvzgk45raif97173";
    };
  };
  
  slimv = vimUtils.buildVimPlugin {
    name = "slimv";
    src = fetchFromGitHub {
      owner = "kovisoft";
      repo = "slimv";
      rev = "d32a9ebe4d5c803f595cb3d1b213f1048bdc8b3e";
      sha256 = "0wbi9421pncyciq9p5xwiqyrkld63c7icpjq1ym6iim5rdaxzyx2";
    };
  };

  vim-sneak = vimUtils.buildVimPlugin {
    name = "vim-sneak";
    src = fetchFromGitHub {
      owner = "justinmk";
      repo = "vim-sneak";
      rev = "e4eb91a44a61b0d764d3276226ba901c793a7a6b";
      sha256 = "0z8ivzckrhc5aqw47sms2n0w6345v0j79hgashnj82p2pcra55kp";
    };

    prePatch = "rm ./Makefile";
  };

  vim-slime = vimUtils.buildVimPlugin {
    name = "vim-slime";
    src = fetchFromGitHub {
      owner = "LeOtaku";
      repo = "vim-slime";
      rev = "6f05a53a672ff0787f641fe10da302bf75b3386e";
      sha256 = "0sd2kcndzf1l3w6gvjhyfj7al4ryxsmlcjq80nda6888f1vximcf";
    };
  }; 

  vim-sexp = vimUtils.buildVimPlugin {
    name = "vim-sexp";
    src = fetchFromGitHub {
      owner = "guns";
      repo = "vim-sexp";
      rev = "12292941903d9ac8151513189d2007e1ccfc95f0";
      sha256 = "1mfqbmrbqgnsc34pmcsrc0c5zvgxhhnw4hx4g5wbssfk1ddyx6y0";
    };
  }; 
  
  vim-express = vimUtils.buildVimPlugin {
    name = "vim-express";
    src = fetchFromGitHub {
      owner = "tommcdo";
      repo = "vim-express";
      rev = "2cbe706b4940dd567596b892e2d6af829b096b4b";
      sha256 = "0fcwykwp6dwcs7jkkcxx5g9v9g9csj178c07sl3lcvmgidms79qk";
    };
  };

  vim-gutentags = vimUtils.buildVimPlugin {
    name = "vim-gutentags";
    src = fetchFromGitHub {
      owner = "ludovicchabant";
      repo = "vim-gutentags";
      rev = "b1eb744786ec3e55c1c8ed8ab3221157b426f62e";
      sha256 = "0bx690n6zn28bzw99sis1q177x3s4yzdh6avsv49qpwwdg73s3c4";
    };
  };
  
  vim-mucomplete = vimUtils.buildVimPlugin {
    name = "vim-mucomplete";
    src = fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-mucomplete";
      rev = "43a97046a8451b27134bfeaf6e2af59189e2b334";
      sha256 = "1hm33jn5nkwi3261v543n5szd9bzvvv4bwf7lg8yif4p8aikjlbf";
    };
  };

  shot-f = vimUtils.buildVimPlugin {
    name = "shot-f";
    src = fetchFromGitHub {
      owner = "deris";
      repo = "vim-shot-f";
      rev = "eea71d2a1038aa87fe175de9150b39dc155e5e7f";
      sha256 = "1rxv0z3nfvsi4nms5dl6y28zzc7pk2k68ls1wsq6z1g5rwify0w8";
    };
  };

  clever-f = vimUtils.buildVimPlugin {
    name = "clever-f";
    src = fetchFromGitHub {
      owner = "rhysd";
      repo = "clever-f.vim";
      rev = "89996998782a8f9c2787bf3bb554fa88ceb5ae00";
      sha256 = "1g62kyq4zd0055pgcgphzxjrxwdz63m4gn3jl7jnqrrsb1cl8fyd";
    };
  };

  multiselect = vimUtils.buildVimPlugin {
    name = "multiselect";
    src = fetchFromGitHub {
      owner = "vim-scripts";
      repo = "multiselect";
      rev = "c315443016e6adebe1ef2a243cb0db5039188bd2";
      sha256 = "10gwywfimxsvk3h352cpwaabcdr462rwbnyk4djdlm1dgyfyn296";
    };
  };

  genutils = vimUtils.buildVimPlugin {
    name = "genutils";
    src = fetchFromGitHub {
      owner = "vim-scripts";
      repo = "genutils";
      rev = "e30cc0c3cd333bea3df352041cf51943c548d2e5";
      sha256 = "0dzcm7xwgy7kzs4wmgp4w6js1x4w4wxwcwpybqvmfvbjsa6vgyxk";
    };
  };

  vim-swap = vimUtils.buildVimPlugin {
    name = "vim-swap";
    src = fetchFromGitHub {
      owner = "machakann";
      repo = "vim-swap";
      rev = "80c783db9b0afb3c5bf22606873e36e84ede4eba";
      sha256 = "1xw0pmmw6fdliw7hfkplmkgl24472qdfmgsvld9rgbndliybln9r";
    };
  };

  vim-fish = vimUtils.buildVimPlugin {
    name = "vim-fish";
    src = fetchFromGitHub {
      owner = "dag";
      repo = "vim-fish";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
      sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
    };
  };

  parinfer-rust = 
  let
    src = fetchFromGitHub {
      owner = "eraserhd";
      repo = "parinfer-rust";
      rev = "697aece26f6b2dd504c2bf0f6e12a6b74a68fdcc";
      sha256 = "09gz16z56iizznqrz91cq07x2s2fk203sqdl228afcbr49ir7gz0";
    };
  in
  let
  parinfer-rust-package = pkgs.rustPlatform.buildRustPackage rec {
    name = "parinfer-rust-${version}";
    version = "a26808b";

    inherit src;
    cargoSha256 = "0mwjvrip2imjy5qy90avsd02745wwcff9aycasv50mwfkgj5py8y";

    doCheck = false;  
  };
  in
  vimUtils.buildVimPlugin rec {
    name = "parinfer-rust";
    version = "a26808b";

    inherit src;
    postBuild = ''
      mkdir -p ./target/release
      cp ${parinfer-rust-package}/bin/libparinfer_rust.so target/release
    '';
  };
} // (callPackage ./ncm2.nix {})
