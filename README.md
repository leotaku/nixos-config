# nixos-config

A git repository for my Nix configurations

## Design

This repository contains most of my Nix-related efforts, including
packages, systems, nixos modules and home-manager modules.

## Points of Interest

Casual observers might find the following files to be of interest:

* `Justfile` :: A task-runner file containing some commonly used actions
* `pkgs/default.nix` :: Some interesting packages, including custom unstable Emacs build
* `modules/backup.nix` :: An easy to use backup module based on restic

## Continuous Integration

All packages in `pkgs` are evaluated and built by Hercules CI.
The results can be viewed [here](https://hercules-ci.com/github/leotaku/nixos-config).

In the future it might be possible to also perform CI on full systems.

## Help

If you are interested in any particular aspect of this repository, don't hesitate to open a GitHub issue.

## License

This project is licensed under the [MIT](LICENSE) license.

**Note:** The MIT license does not apply to the packages built by Nix expressions in this repository, merely to the files in this repository (the Nix expressions, build scripts, NixOS modules, etc.).  It also might not apply to patches and configuration files included in in this repository, which may be derivative works of the packages to which they apply.  The aforementioned artifacts are all covered by the licenses of the respective packages.

**Note:** The contents of directory the directory `pkgs/sddm/haze` were initially adapted from the configurations of the GitHub user [jurassicplayer](https://github.com/jurassicplayer/Weeb-Themes).  Their project contains only an informal notice allowing use of the work with attribution.
