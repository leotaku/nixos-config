{ callPackage, vimUtils, fetchFromGitHub, pkgs, ... }:

{
  TagHighlight = let version = "05449e727b55";
  in vimUtils.buildVimPlugin {
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
      rev = "de439d7c06cffd0839a29045a103fe4b44b15cdc";
      sha256 = "0yfsb0d9ly8abmc95nqcmr8r8ylif80zdjppib7g1qj1wapdhc69";
    };
  };

  vim-delve = vimUtils.buildVimPlugin {
    name = "vim-delve";
    src = fetchFromGitHub {
      owner = "sebdah";
      repo = "vim-delve";
      rev = "67f176074f511ede910941c42bfc94c72c4f788d";
      sha256 = "0ngbsd25qlkbg2psr4cc66c66rxip69hq8q6fj3f84b5i3f47rcj";
    };
  };

  Mundo = vimUtils.buildVimPlugin {
    name = "Mundo";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "43c4fb3fd40e5eaf2476eb88ef983eb56789c522";
      sha256 = "08256z0dh6l1w77p48qh2zhqhpmincsmcc6zvbrm1f1gzfhh3nrx";
    };
  };

  vim-instant-markdown = vimUtils.buildVimPlugin {
    name = "vim-instant-markdown";
    src = fetchFromGitHub {
      owner = "suan";
      repo = "vim-instant-markdown";
      rev = "081a6f7f228a19022e8ce7672798b83edd596586";
      sha256 = "1xwhna2s9xfzp6s41wa57rwl78x6bqw9njc92a9brxg27vbxd7gf";
    };
  };

  endwise = vimUtils.buildVimPlugin {
    name = "endwise";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-endwise";
      rev = "bf90d8be447de667f4532b934d1a70881be56dd8";
      sha256 = "1czx891via5783yk222mhki94wvq75hxxp1xk1d5m90vwqb3azfn";
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
      rev = "a1787cb55e45b8778eaed7b392648deb4706cd0b";
      sha256 = "1rn7izmr0wbrrb5l8172fxyssfcs3pi3k1gw5mna3gj3rj7fq2wj";
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
      rev = "5a415547e7584eba0bebe087fd553e13c76e8842";
      sha256 = "07q7865bbbq28pf3ijm56qr3wk0xsq0dprhscyjjqjy0jqrgzjra";
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
      rev = "6191622d5806d4448fa2285047936bdcee57a098";
      sha256 = "1qz21jizcy533mqk9wff1wqchhixkcfkysqcqs0x35wwpbri6nz8";
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
      rev = "9f6237b4b9950233a7edd8609eb2a89bdb9c84f4";
      sha256 = "19v83fvv8f5iqpxjlnnmmn6mcgn2jg8zg6qdpr2mzlqww367qjky";
    };
  };

  vim-sneak = vimUtils.buildVimPlugin {
    name = "vim-sneak";
    src = fetchFromGitHub {
      owner = "justinmk";
      repo = "vim-sneak";
      rev = "7afd63b4552b0827622ae27ff4c9eca056dd3521";
      sha256 = "0g9vsxbrsfcc0n7rq9m0331rcjyv35z0yc0d2cwkg939bzqw75qx";
    };

    prePatch = "rm ./Makefile";
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
      rev = "31c0ead56428529c8991e45c0ac0fa7dd99e3bd0";
      sha256 = "1x1f52awqnbpnd4y2zsv140rwjml6b5r5laim49n1i1z9vnwknjk";
    };
  };

  vim-mucomplete = vimUtils.buildVimPlugin {
    name = "vim-mucomplete";
    src = fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-mucomplete";
      rev = "f13357964cc074d4fe747787065bfb19046f7fce";
      sha256 = "0kqik4xgnk3cw7ls53djij086rbp49klzckc4zs4ph4cjwcpjhgq";
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
      rev = "48706f4124d77d814de0ad5fa264fd73ab35df38";
      sha256 = "1gf7gi84bdylqlask83mdl71djmix0liqi0r3ah4l5qf40yz5ndn";
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
      rev = "e52ff679c88f4aa7a7afe77fb42af78c93ed33c8";
      sha256 = "0rqvxqqk961syawmyc2qdfb4w9ilb1r3mxxij2ja1jbhl1f3w4vq";
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

  parinfer-rust = let
    src = fetchFromGitHub {
      owner = "eraserhd";
      repo = "parinfer-rust";
      rev = "5ea376394ea954940d937f182029cc29088c0fc0";
      sha256 = "0xkian8g2wlxmf8ksfc1pzv6j5x8081b88jcpmk0dncpac3yg242";
    };
  in let
    parinfer-rust-package = pkgs.rustPlatform.buildRustPackage rec {
      name = "parinfer-rust-${version}";
      version = "a26808b";

      inherit src;
      cargoSha256 = "080ji43p3plr489vkwnbcv3c5nxfx0giqhipqiq0f5plm84ql1k5";

      doCheck = false;
    };
  in vimUtils.buildVimPlugin rec {
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
} // (callPackage ./ncm2.nix { })
