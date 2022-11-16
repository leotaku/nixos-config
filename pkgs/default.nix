self: super:
with self; {
  # Custom packages
  alegreya = callPackage ./alegreya/default.nix { };
  besley = callPackage ./besley/default.nix { };
  goatcounter = callPackage ./goatcounter/default.nix { };
  n30f = callPackage ./n30f/default.nix { };
  sddm-themes = callPackage ./sddm/default.nix { };

  # Customized packages
  aspell-custom = (aspellWithDicts lib.attrValues).overrideAttrs
    (oldAttrs: { ignoreCollisions = true; });
  hunspell-custom = hunspellWithDicts (lib.mapAttrsToList
    (n: v: if (lib.isDerivation v && !v.meta.unfree) then v else null)
    hunspellDicts);
  nuspell-custom = nuspellWithDicts (lib.mapAttrsToList
    (n: v: if (lib.isDerivation v && !v.meta.unfree) then v else null)
    hunspellDicts);
  firefox-custom = firefox-devedition-bin.override
    (old: { extraPolicies = { "DisableAppUpdate" = true; }; });

  # Source overrides
  awesome-git = callPackage ./awesome/default.nix { };
  emacs-git = callPackage ./emacs/emacs-git.nix { };
  emacs-custom = callPackage ./emacs/default.nix { };
  emacs-git-custom =
    callPackage ./emacs/default.nix { emacs = self.emacs-git; };
}
