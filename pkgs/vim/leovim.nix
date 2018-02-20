{ pkgs, ... }:

pkgs.neovim.override {
  vimAlias = true; 
  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.vimPluginsLeo;
  configure.vam.pluginDictionaries = [
    "vim-nix"
    "vim-instant-markdown" 
    "surround" 
    "vim-startify" 
    "The_NERD_tree" 
    "nerdtree-git-plugin"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';
}

