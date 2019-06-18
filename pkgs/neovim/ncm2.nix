{ fetchFromGitHub, vimUtils, pkgs, ... }: {
  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "5bd16749b1f8aeb04ddde191c46fa9be237f2eea";
      sha256 = "0nwf32y09lgiz20019ja72ah3bz5h48ama50lpbh6rl5miq4b5nk";
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
      rev = "a7462f3b7036dce045a472d8ec9d8fb9fb090212";
      sha256 = "0f3qp33s5nh9nha9cgxggcmh7c1a5yrwvyyrszlh0x8nrzm1v1ma";
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
      rev = "7315d39b6f55b87721fe0cbe5ebe64f2adff19d4";
      sha256 = "1ijmlk5n7pr27a9hf7b5761vg9hhx0qqzvb73r2f4xdjdx5g3d8k";
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
      rev = "1d42750114e47a31286268880affcd66c6ae48d5";
      sha256 = "14q76n5c70wvi48wm1alyckba71rp5300i35091ga197nkgphyaz";
    };
  };

  ncm2-tmux = vimUtils.buildVimPlugin {
    name = "ncm2-tmux";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-tmux";
      rev = "17fa16ac1211af3d8e671f1591939d6f37bdd3bd";
      sha256 = "1g99vbrdz06i36gpa95crwixj61my7c9miy7mbpfbiy4zykf2wl2";
    };
  };
}
