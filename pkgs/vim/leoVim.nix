{ pkgs, ... }:

pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // pkgs.vimPluginsLeo;
  vimrcConfig.vam.pluginDictionaries = [
    "vim-nix"
    "vim-instant-markdown"
    "vim-pandoc-syntax"
    "vim-rmarkdown"
    "vim-pandoc"
    #"vimpreviewpandoc"
    "surround"
    "vim-startify" 
    "The_NERD_tree" 
    "nerdtree-git-plugin"
  ];
  vimrcConfig.customRC = ''
	source ~/.config/nvim/init.vim
   	'';
}

