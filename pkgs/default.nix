self: super:

{
  # Custom packages
  instant-markdown-d = (super.callPackage ./instant-markdown-d/default.nix {}).package;
  gtop =  (super.callPackage ./gtop/default.nix {}).package;
  customVimPlugins = super.callPackage ./vim/customPlugins.nix {};
  leovim = super.callPackage ./neovim/leovim.nix {};
  leoVim = super.callPackage ./vim/leoVim.nix {};
  orgEmacs = super.callPackage ./emacs/orgmode.nix {};
  orgEmacsConfig = super.callPackage ./emacs/configuration-package.nix {};
  athameVim = super.callPackage ./vim/athameVim.nix {};
  windowchef = super.callPackage ./windowchef/default.nix {};
  farfetch = super.callPackage ./farfetch/default.nix {};
  customPythonPackages = super.callPackage ./python/customPackages.nix {};
  mullvad-gtk = super.callPackage ./mullvad/gtk-client.nix {};
  torrench = super.callPackage ./torrench/default.nix {};
  broadcom-rpi3-extra = super.callPackage ./raspberry/broadcom_driver.nix {};
  subtle = super.callPackage ./subtle/default.nix {};
  eventd = super.callPackage ./eventd/default.nix {};
  interrobang = super.callPackage ./interrobang/default.nix {};
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  dmenu3 = super.callPackage ./dmenu/dmenu3.nix {};
  urxvtWithExtensions = super.callPackage ./urxvt/default.nix {};
  seashells = super.callPackage ./seashells/default.nix {};
  xgetres = super.callPackage ./xgetres/default.nix {};
  gotop = super.callPackage ./gotop/default.nix {};
  num9menu = super.callPackage ./9menu/default.nix {};
  gohufont-ttf = super.callPackage ./gohufont-ttf/default.nix {};
  #meson = super.callPackage ./meson/default.nix {};
  # Not currently working
  #howm = super.callPackage ./howm/default.nix {};
  #cottage = super.callPackage ./cottage/default.nix {};
  #gpick = super.callPackage ./gpick/default.nix {};
  # Package Overrides
  num2bwm = super.callPackage ./2bwm/default.nix {};
  wmutils-core = super.callPackage ./wmutils/core.nix {};
  wmutils-opt = super.callPackage ./wmutils/opt.nix {};
  ncmpcpp = super.ncmpcpp.override { visualizerSupport=true; outputsSupport=true; clockSupport=true; };
  polybar = super.polybar.override { githubSupport = true; mpdSupport = true; };
  oh-my-zsh-custom = super.callPackage ./zsh/oh-my-zsh.nix {};
  #ranger = super.callPackage ./ranger/default.nix {};
  # Global env for stupid programmes
  #pythonForR = super.callPackage ../env/python/rSystem.nix {};
}
