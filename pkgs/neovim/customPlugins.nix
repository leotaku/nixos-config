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
      rev = "ad30cab549ab8b6014308fe7c095325c08dec211";
      sha256 = "10qkmdy2i9nikn82sdfvsa712lclc2y35jg4lvj98rfnxwks0bvc";
    };
  };

  Mundo = vimUtils.buildVimPlugin {
    name = "Mundo";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "3eb20180e561da98d49a52b3a5d7af2bcda37162";
      sha256 = "021lyyibqxkvjamb8yjmf6vvw6d1xfypnm1mw6jkjdp2zm46m40h";
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
      rev = "f67d022169bd04d3c000f47b1c03bfcbc4209470";
      sha256 = "0lq2sphh2mfciva184b4b3if202hr4yls4d2gzbjx7ibch45zb9i";
    };
  };

  vim-autoswap = vimUtils.buildVimPlugin {
    name = "vim-autoswap";
    src = fetchFromGitHub {
      owner = "gioele";
      repo = "vim-autoswap";
      rev = "e587e4b14a605d8921942ba65a37583813289272";
      sha256 = "0l0ijbdl2s9p5i3cxfkq8jncncz38qprp51whbjcda485d1knk9n";
    };
  };

  vim-rmarkdown = vimUtils.buildVimPlugin {
    name = "vim-surround";
    src = fetchFromGitHub {
      owner = "vim-pandoc";
      repo = "vim-rmarkdown";
      rev = "1b97e1dc48bfe6db8aad0f9e1d11e15f13d0a4a6";
      sha256 = "0r3h0z4wpmq1vjb3blv4lvdbj44j4ja9x85bk741n6mmsyf24ifm";
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
      rev = "2073e2dd9fa0172ccdba92b3f0df25642a69f7db";
      sha256 = "1d6d2aca73rvhz7gpi2d1g2il9qy45pfw1kbrrqgvmik016i6l1y";
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
      rev = "3b6365692bba8c32fcc7962319e183904299780b";
      sha256 = "1y81i7lyw35lbslsi3zlvyq24skxqikm8gsagb7y0wwgkw41pizv";
    };
  };

  vim-sneak = vimUtils.buildVimPlugin {
    name = "vim-sneak";
    src = fetchFromGitHub {
      owner = "justinmk";
      repo = "vim-sneak";
      rev = "91192d8969af1d86c98beff4001612976ea25d7a";
      sha256 = "0nmbrp0ma9s3yfzb8z70l0pcxv8p115zv6fz4injxn1c436x9337";
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
      rev = "93616e4c0ccfafe52ae329c7dd220d7b5c7d5f80";
      sha256 = "12qcf34fxgzsilx1wkh219avvkq7a5q9x3kdcqy3ai8g05fpx619";
    };
  };
  
  vim-mucomplete = vimUtils.buildVimPlugin {
    name = "vim-mucomplete";
    src = fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-mucomplete";
      rev = "62a2453a3a750632827d45cc341f2abd73c4c917";
      sha256 = "18lna3459jfav1rmqddnnvqwabbl6bk66vwmhahwhi7dcv3b912v";
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
      rev = "425b76c24ae286abd3cdc222574b9d6b789642bb";
      sha256 = "0j6baas2vxj3l7qimskxxff0a7yl9maa0rkwd32rfk46p2918xck";
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
      rev = "b8d636e0ef5f431752585fc5562f897a9d236d2a";
      sha256 = "129ds1y8j9dgsizwi1md5nhb49dh88xmymdy7sz5lg3zc9h37pvr";
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
      rev = "506ae2b25a9b84d964804c07ab359f0b108d6df5";
      sha256 = "1jir8krysz7gnvq0gdha9canvc4gw19f8kyniqnm90pb9wmlp582";
    };
  in
  let
  parinfer-rust-package = pkgs.rustPlatform.buildRustPackage rec {
    name = "parinfer-rust-${version}";
    version = "a26808b";

    inherit src;
    cargoSha256 = "080ji43p3plr489vkwnbcv3c5nxfx0giqhipqiq0f5plm84ql1k5";

    doCheck = false;  
  };
  in
  vimUtils.buildVimPlugin rec {
    name = "parinfer-rust";
    version = "a26808b";

    inherit src;
    preConfigure = ''
    rm ./Makefile
    '';
    postBuild = ''
      mkdir -p ./target/release
      cp ${parinfer-rust-package}/bin/libparinfer_rust.so target/release
    '';
  };
} // (callPackage ./ncm2.nix {})
