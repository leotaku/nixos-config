let sources = import ../sources/nix/sources.nix;
in self: super:
with self; {
  # Custom packages
  alegreya = callPackage ./alegreya/default.nix { };
  besley = callPackage ./besley/default.nix { };
  catimg = callPackage ./catimg/default.nix { };
  chroma = callPackage ./chroma/default.nix { };
  gitbatch = callPackage ./gitbatch/default.nix { };
  n30f = callPackage ./n30f/default.nix { };
  sddm-themes = callPackage ./sddm/default.nix { };
  zplugin = callPackage ./zplugin/default.nix { };
  zplugin-install = callPackage ./zplugin/install.nix { };

  # Customized packages
  ncmpcpp = super.ncmpcpp.override {
    visualizerSupport = true;
    outputsSupport = true;
    clockSupport = true;
  };
  polybar = super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
  };
  sddm = super.sddm.overrideAttrs (oldAttrs: {
    buildInputs = with qt5;
      oldAttrs.buildInputs ++ [ qtgraphicaleffects qtmultimedia ];
  });
  rxvt-unicode-custom = super.rxvt_unicode_with-plugins.override {
    plugins = with super; [ urxvt_vtwheel urxvt_perls ];
  };
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv/config.h; };
  # NOTE: This only works while using systemd-resolved
  wireguard-tools =
    super.wireguard-tools.override { openresolv = self.systemd; };

  };
  # Emacs
  emacs-git = callPackage ./emacs/emacs-git.nix { };
  emacs-custom = callPackage ./emacs/default.nix { };
  emacs-git-custom =
    callPackage ./emacs/default.nix { emacs = self.emacs-git; };
  ox-blorf = callPackage ./emacs/ox-blorf.nix { };

  # External
  mozilla = import sources.nixpkgs-mozilla self super;
  pboy = import sources.pboy;
  morph = callPackage (sources.morph + "/nix-packaging") { };
  haskell = super.haskell // {
    compiler = callPackage sources.old-ghc-nix { } // super.haskell.compiler;
  };
}
