{ oh-my-zsh, zsh-syntax-highlighting, fetchFromGitHub, ... }:

let 
  srcs = { 
    nix-shell = fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "81fb4ea";
      sha256 = "0wwcvzl3avrky5gi0gxz0rf5z675cm9r2v2v7rgyazzrzj8z578c";
    };
    zsh-async = fetchFromGitHub {
      owner = "mafredri";
      repo = "zsh-async";
      rev = "6d0f41b";
      sha256 = "048pbakvbs5kqwzp4lmrn5wdj1qsdygc8fi73bri9sv6ikvm12zy";
    };
  };
in
  
oh-my-zsh.overrideAttrs (old: rec {
  phases = [ "installPhase" "fixupPhase" ];
  preFixup =  ''
  mkdir -p $out/share/oh-my-zsh/plugins/nix-shell
  mkdir -p $out/share/oh-my-zsh/plugins/syntax-highlighting
  mkdir -p $out/share/oh-my-zsh/plugins/async
  cp ${srcs.nix-shell}/* $out/share/oh-my-zsh/plugins/nix-shell -r
  cp ${srcs.zsh-async}/* $out/share/oh-my-zsh/plugins/async -r
  echo "source ${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > $out/share/oh-my-zsh/plugins/syntax-highlighting/syntax-highlighting.plugin.zsh
  '';
})
