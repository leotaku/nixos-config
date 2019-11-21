# nixos-config

A git repository for my Nix configurations

## Design

This repository contains most of my Nix-related efforts, including
packages, systems, nixos modules and home-manager modules.

## Points of Interest

Outside observer might find the following to be of interest:

* `Justfile` :: A task-runner file containing some commonly used actions
* `pkgs/default.nix` :: Some interesting packages, including custom Emacs 27.01 build
* `modules/backup.nix` :: An easy to use backup module based on restic

## Continuous Integration

All packages in `pkgs` are evaluated and built by Hercules CI.
The results can be viewed [here](https://hercules-ci.com/github/leotaku/nixos-config).

In the future it might be possible to also perform CI on full systems.

## Help

If you are interested in any particular aspect of this repository,
don't hesitate to open an GitHub issue.
