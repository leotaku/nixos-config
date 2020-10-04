self: super:
let inputs = import ../files/inputs.nix self;
in with self; {
  # Custom packages
  alegreya = callPackage ./alegreya/default.nix { };
  besley = callPackage ./besley/default.nix { };
  build2 = callPackage ./build2/default.nix { };
  catimg = callPackage ./catimg/default.nix { };
  goatcounter = callPackage ./goatcounter/default.nix { };
  n30f = callPackage ./n30f/default.nix { };
  sddm-themes = callPackage ./sddm/default.nix { };

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
    # FIXME: We don't know when the QT version for SDDM could change
    buildInputs = with qt514;
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
  nuspell-custom = nuspellWithDicts
    (lib.mapAttrsToList (n: v: if (lib.isDerivation v) then v else null)
      hunspellDicts);

  # Source overrides
  awesome-git = callPackage ./awesome/default.nix { };
  emacs-git = callPackage ./emacs/emacs-git.nix { };
  emacs-custom = callPackage ./emacs/default.nix { };
  emacs-git-custom =
    callPackage ./emacs/default.nix { emacs = self.emacs-git; };

  # External
  morph = callPackage (inputs.morph + "/nix-packaging") { };
  mozilla = import inputs.nixpkgs-mozilla self super;
  update-nix-fetchgit = callPackage inputs.update-nix-fetchgit { };
}
