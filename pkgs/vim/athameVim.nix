{ pkgs, ... }:

pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // pkgs.customVimPlugins;
  vimrcConfig.vam.pluginDictionaries = [
    "surround"
    "airline"
  ];
  vimrcConfig.customRC = ''
	source ~/.config/nvim/init.vim
   	'';
}

