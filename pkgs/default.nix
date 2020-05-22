let sources = import ../sources/nix/sources.nix;
in self: super:
with self; {
  # Custom packages
  alegreya = callPackage ./alegreya/default.nix { };
  besley = callPackage ./besley/default.nix { };
  catimg = callPackage ./catimg/default.nix { };
  chroma = callPackage ./chroma/default.nix { };
  n30f = callPackage ./n30f/default.nix { };
  sddm-themes = callPackage ./sddm/default.nix { };
  zinit = callPackage ./zinit/default.nix { };
  zinit-install = callPackage ./zinit/install.nix { };

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
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv/config.h; };

  # Hard customizations
  aspell-custom =
    (aspellWithDicts (a: lib.mapAttrsToList (n: v: v) a)).overrideAttrs
    (oldAttrs: { ignoreCollisions = true; });
  hunspell-custom = hunspellWithDicts
    (lib.mapAttrsToList (n: v: if (lib.isDerivation v) then v else null)
      hunspellDicts);
  rxvt-unicode-custom = rxvt-unicode.override {
    configure = { availablePlugins, ... }: {
      plugins = with availablePlugins; [ vtwheel perls ];
    };
  };

  # Emacs
  emacs-git = callPackage ./emacs/emacs-git.nix { };
  emacs-custom = callPackage ./emacs/default.nix { };
  emacs-git-custom =
    callPackage ./emacs/default.nix { emacs = self.emacs-git; };

  # External
  mozilla = import sources.nixpkgs-mozilla self super;
  pboy = import sources.pboy;
  morph = callPackage (sources.morph + "/nix-packaging") { };
  haskell = super.haskell // {
    compiler = callPackage sources.old-ghc-nix { } // super.haskell.compiler;
  };
}
