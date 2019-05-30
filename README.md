# nixos-config

A git repository to store my nix configurations in


## Idea

This repository contains the configurations for my NixOS systems, with end-user systems being stored in `/local` and NixOps deployments being stored in `/deploments`.

As soon as there are more than one end-user systems the file structure for them should be revised.


## Deploying


### Local Systems

New *raw* NixOS systems can be installed on an existing NixOS machine by first adding new system description to a subfolder in `/local`, creating a matching hardware configuration in `/hardware` and then linking the configuration to `/etc/nixos/configuration.nix`.

Deploy the (currently only) system by running:

```sh
ln -s ./local/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch --install-bootloader
```

### NixOps Deployments

Similarly NixOps deployments live in `/deployments`. Servers comprising a singular network should ideally all be contained in a single deployment (but may be split across multiple files). Hardware specific information should still always live in `/hardware`.

Create the (currently only) deployment by running:

```sh
nixops create -d combined $(pwd)/deployments/combined.nix
```

And deploy it using:

```sh
nixops deploy -d combined -I "nixpkgs=./sources/links/nixpkgs/nixos-18_09-small"
```


### TODO NixOS Images

<https://nixos.mayflower.consulting/blog/2018/09/11/custom-images/>


## File structure


### `/local`

This directory contains system descriptions intended for local (read non-NixOps) use. If there is more than one system, configurations should be sorted in subdirs.

The current structure is:

```
/local/configuration.nix
/local/system.nix
/local/user.nix
```

with `/local/configuration.nix` intended to be symlinked to `/etc/nixos/configuration.nix`.


### `/deployments`

This directory contains system deployments deployed using NixOps.


### `/hardware`

This directory contains the hardware dependent configuration of all local and remote systems in this repository.


### `/home-manager`

This directory contains home-manager user configuration.


### `/modules`

This directory contains custom NixOS modules.


### `/plugables`

This directory contains reusable snippets of configuration.


### `/pkgs`

This directory contains custom Nix pkg descriptions.

#### `pkgs/unused`
This directory contains custom Nix pkg descriptions that are not currently in use.


### `/env`
  This directory contains build instructions for development environments. They should usually be sorted by language and given descriptive names.


### `/sources`

This directory contains files related to my automatic system for transparently managing external Nix sources such as nixpkgs. It probably needs to be documented before being useful to the public.


### `/files`

This directory contains miscellaneous files needed for various parts of my NixOS workflow. They should be individually documented.


## Additional
### TODO add `/images` tools
### TODO document all in `/files`
### TODO document `/sources/`
