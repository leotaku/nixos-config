{ zsh, fetchurl, fetchFromGitHub, ncurses, pcre, athameVim , which, ... }:

let 
  srcs = { 
    athame = fetchFromGitHub {
      owner = "ardagnir";
      repo = "athame";
      rev = "a05d6a1";
      sha256 = "138zz5gxwnzvfxlflvx4fwy5f46x5965dbj611fa7paqangi1npj";
    };
    vimbed = fetchFromGitHub {
      owner = "ardagnir";
      repo = "vimbed";
      rev = "61f3ec7";
      sha256 = "04zz1a18fdwxhi02j24w6xibkgappmy4y14khf039v600pw2921r";
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
