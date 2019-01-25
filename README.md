# nixos-config

A git repository to store my nix configurations in


## Idea

This repository contains the configurations for my NixOS systems, with end-user systems being stored in `/local` and NixOps deployments being stored in `/deploments`.

As soon as there are more than one end-user systems the file structure for them should be revised.


## Deploying


### Local Systems

New _"raw"_ NixOS systems can be installed on an existing NixOS machine by first adding new system description to a subfolder in `/local`, creating a matching hardware configuration in `/hardware` and then linking the configuration to `/etc/nixos/configuration.nix`.

`REWORK PLANNED`

Deploy the current (only) system by running:

```sh
ln -s ./local/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch --install-bootloader
```


### NixOps Deployments

Similarly NixOps deployments live in `/deployments`. Servers comprising a singular network should ideally all be contained in a single deployment (but may be split across multiple files). Hardware specific information should still always live in `/hardware`.

Create the current (only) deployment by running:

```sh
nixops create -d combined $(pwd)/deployments/combined.nix
```

And deploy it using:

```sh
nixops deploy -d combined -I "nixpkgs=./sources/links/nixpkgs/nixos-18_09-small"
```


### TODO NixOS Images


## File structure


### `/local`

This directory contains system descriptions intended for local (read non-NixOps) use. Possibly sorted in subdirs. `TO BE IMPLEMENTED`

The current structure is:

```nil
/local/configuration.nix
/local/system.nix
/local/user.nix
```

with `/local/configuration.nix` intended to be symlinked to `/etc/nixos/configuration.nix`.


### `/deployments`

This directory contains system deployments deployed using NixOps.


### `/hardware`

This directory contains the hardware dependent configuration of all local and deployed systems in this repository.


### `/home-manager`

This directory contains home-manager user configuration.


### `/modules`

This directory contains custom NixOS modules.


### `/plugables`

This directory contains reusable snippets of configuration.


### `/pkgs`

This directory contains custom Nix pkg descriptions.

1.  `pkgs/unused`

    This directory contains custom Nix pkg descriptions that are not currently in use.


### `/env`

This directory contains build instructions for development environments. They should usually be sorted by language and given descriptive names.


### `/sources`

This directory contains files related to my automatic system for transparently managing external Nix sources such as nixpkgs.
It is unnecessary complicated and needs to be majorly improved and well-documented before being useful to the public.


### `/files`

This directory contains miscellaneous files needed for various parts of my NixOS workflow. They should be individually documented.


## Additional


### TODO incorporate nix-get


### TODO `/images` tools


### TODO explain all in `/files`


# Customize     :ARCHIVE:
