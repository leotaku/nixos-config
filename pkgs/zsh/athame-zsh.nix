{ zsh, fetchurl, fetchFromGitHub, ncurses, pcre, athameVim , which, ... }:

let 
  srcs = { 
    athame = fetchFromGitHub {
      owner = "ardagnir";
      repo = "athame";
      rev = "v1.0";
      sha256 = "0ikwrhp71kaqzmhmq9ax5p3rmkfrfpkj0qr3xikq6gf3q1jbi557";
    };
    vimbed = fetchFromGitHub {
      owner = "ardagnir";
      repo = "vimbed";
      rev = "dca24bb";
      sha256 = "0sh98vhh53bll7psbxwvv9n9ldrxcsvabpkqfc5j5hqqxyavcsz9";
    };
  };
in
zsh.overrideAttrs (old: rec {
  prePatch =  "
  mkdir athame
  mkdir vimbed
  cp ${srcs.athame}/* ./athame -r
  cp ${srcs.vimbed}/* ./vimbed -r
  ";
  #patches = [ ./athame/zsh.patch ];
  postPatch = "
  patch -p1 < \"./athame/zsh.patch\"
  cp -r ./vimbed ./Src/Zle
  cp ./athame/athame.* ./Src/Zle
  cp ./athame/athame_util.h ./Src/Zle
  cp ./athame/athame_zsh.h ./Src/Zle/athame_intermediary.h
  ";
  buildPhase = ''
  make CFLAGS="-std=c99" \
  ATHAME_VIM_BIN=$(which vim) \
  ATHAME_USE_JOBS_DEFAULT=1
  '';
  buildInputs = [ ncurses pcre which ];
  propagatedBuildInputs = [ athameVim ];
})
