{ sddm, qt5full, ... }:

sddm.overrideAttrs (old: rec {
  buildInputs = (old.buildInputs // [ qt5Full ]);
})
