self: super:

{
  # Custom packages
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  athameVim = super.callPackage ./vim/athameVim.nix {};
  broadcom-rpi3-extra = super.callPackage ./raspberry/broadcom_driver.nix {}; # TODO move back to rpi system
  catimg = super.callPackage ./catimg/default.nix {};
  dmenu3 = super.callPackage ./dmenu/dmenu3.nix {};
  eventd = super.callPackage ./eventd/default.nix {};
  farfetch = super.callPackage ./farfetch/default.nix {};
  gohufont-ttf = super.callPackage ./gohufont-ttf/default.nix {};
  gotop = super.callPackage ./gotop/default.nix {};
  gtop =  (super.callPackage ./gtop/default.nix {}).package;
  instant-markdown-d = (super.callPackage ./instant-markdown-d/default.nix {}).package;
  interrobang = super.callPackage ./interrobang/default.nix {};
  mullvad-gtk = super.callPackage ./mullvad/gtk-client.nix {};
  num9menu = super.callPackage ./9menu/default.nix {};
  seashells = super.callPackage ./seashells/default.nix {};
  subtle = super.callPackage ./subtle/default.nix {};
  torrench = super.callPackage ./torrench/default.nix {};
  windowchef = super.callPackage ./windowchef/default.nix {};
  xgetres = super.callPackage ./xgetres/default.nix {};

  # Customized packages
  leoVim = super.callPackage ./vim/leoVim.nix {};
  leovim = super.callPackage ./neovim/leovim.nix {};
  ncmpcpp = super.ncmpcpp.override { visualizerSupport=true; outputsSupport=true; clockSupport=true; };
  num2bwm = super.callPackage ./2bwm/default.nix {};
  oh-my-zsh-custom = super.callPackage ./zsh/oh-my-zsh.nix {};
  orgEmacs = super.callPackage ./emacs/orgmode.nix {};
  orgEmacsConfig = super.callPackage ./emacs/configuration-package.nix {};
  polybar = super.polybar.override { githubSupport = true; mpdSupport = true; };
  sxiv = super.sxiv.override { conf = builtins.readFile /home/leo/nixos-config/files/config.h; }; # TODO fix path
  wmutils-core = super.callPackage ./wmutils/core.nix {};
  wmutils-opt = super.callPackage ./wmutils/opt.nix {};

  # Collections
  customPythonPackages = super.callPackage ./python/customPackages.nix {};
  customVimPlugins = super.callPackage ./vim/customPlugins.nix {};
}
