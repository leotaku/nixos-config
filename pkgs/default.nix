self: super:

let
  sources = import ../sources/nix/sources.nix;
in
{
  # Custom packages
  alegreya = super.callPackage ./alegreya/default.nix { };
  besley = super.callPackage ./besley/default.nix { };
  catimg = super.callPackage ./catimg/default.nix { };
  chroma = super.callPackage ./chroma/default.nix { };
  gitbatch = super.callPackage ./gitbatch/default.nix { };
  n30f = super.callPackage ./n30f/default.nix { };
  sddm-themes = super.callPackage ./sddm/default.nix { };
  zplugin-install = super.callPackage ./zplugin/install.nix { };

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
  leovim = super.callPackage ./neovim/leovim.nix { };
  sddm = super.sddm.overrideAttrs (oldAttrs: {
    buildInputs = with super.qt5;
      oldAttrs.buildInputs ++ [ qtgraphicaleffects qtmultimedia ];
  });
  rxvt-unicode-custom = super.rxvt_unicode_with-plugins.override {
    plugins = with super; [ urxvt_vtwheel urxvt_perls ];
  };
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv/config.h; };
  # NOTE: This only works while using systemd-resolved
  wireguard-tools =
    super.wireguard-tools.override { openresolv = self.systemd; };

  # Emacs
  emacs-git = super.callPackage ./emacs/emacs-git.nix { };
  emacs-custom = super.callPackage ./emacs/default.nix { };
  emacs-git-custom = super.callPackage ./emacs/default.nix {
    emacs = self.emacs-git;
  };

  # External
  cachix = import sources.cachix;
  mozilla = import sources.nixpkgs-mozilla self super;
  pboy = import sources.pboy;
  morph = super.callPackage (sources.morph + "/nix-packaging") { };
  haskell = super.haskell // {
    compiler = super.callPackage sources.old-ghc-nix {} // super.haskell.compiler;
  };

  # Collections
  customVimPlugins = super.callPackage ./neovim/customPlugins.nix { };
}
