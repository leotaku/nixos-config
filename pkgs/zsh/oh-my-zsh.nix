{ oh-my-zsh, fetchFromGitHub, ... }:

let 
  srcs = { 
    nix-shell = fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "81fb4ea";
      sha256 = "0wwcvzl3avrky5gi0gxz0rf5z675cm9r2v2v7rgyazzrzj8z578c";
    };
  };
in
  
oh-my-zsh.overrideAttrs (old: rec {
  phases = [ "installPhase" "fixupPhase" ];
  preFixup =  "
  mkdir $out/share/oh-my-zsh/plugins/nix-shell
  cp ${srcs.nix-shell}/* $out/share/oh-my-zsh/plugins/nix-shell -r
  ";
})
