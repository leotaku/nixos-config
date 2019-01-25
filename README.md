- [nixos-config](#org345afc7)
  - [Idea](#org850a1f9)
  - [Deploying](#orgf723d62)
    - [Local Systems](#org4f839db)
    - [NixOps Deployments](#org5a10311)
    - [NixOS Images](#org757c2e5)
  - [File structure](#org3cd7f56)
    - [`/local`](#org016ec25)
    - [`/deployments`](#orgce3e47a)
    - [`/hardware`](#org9ec75cb)
    - [`/home-manager`](#orgb7e8fa7)
    - [`/modules`](#org29d536f)
    - [`/plugables`](#org3bb6150)
    - [`/pkgs`](#orgfc5eabe)
    - [`/env`](#org2e77fcc)
    - [`/sources`](#org04fa0e5)
    - [`/files`](#orge4956d4)
  - [Additional](#org0cc54ac)
    - [incorporate nix-get](#orgc4cb4f8)
    - [`/images` tools](#org525beb8)
    - [explain all in `/files`](#org517d537)



<a id="org345afc7"></a>

# nixos-config

A git repository to store my nix configurations in


<a id="org850a1f9"></a>

## Idea

This repository contains the configurations for my NixOS systems, with end-user systems being stored in `/local` and NixOps deployments being stored in `/deploments`.

As soon as there are more than one end-user systems the file structure for them should be revised.


<a id="orgf723d62"></a>

## Deploying


<a id="org4f839db"></a>

### Local Systems

New _"raw"_ NixOS systems can be installed on an existing NixOS machine by first adding new system description to a subfolder in `/local`, creating a matching hardware configuration in `/hardware` and then linking the configuration to `/etc/nixos/configuration.nix`.

`REWORK PLANNED`

Deploy the current (only) system by running:

```sh
ln -s ./local/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch --install-bootloader
```


<a id="org5a10311"></a>

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


<a id="org757c2e5"></a>

### TODO NixOS Images


<a id="org3cd7f56"></a>

## File structure


<a id="org016ec25"></a>

### `/local`

This directory contains system descriptions intended for local (read non-NixOps) use. Possibly sorted in subdirs. `TO BE IMPLEMENTED`

The current structure is:

```nil
/local/configuration.nix
/local/system.nix
/local/user.nix
```

with `/local/configuration.nix` intended to be symlinked to `/etc/nixos/configuration.nix`.


<a id="orgce3e47a"></a>

### `/deployments`

This directory contains system deployments deployed using NixOps.


<a id="org9ec75cb"></a>

### `/hardware`

This directory contains the hardware dependent configuration of all local and deployed systems in this repository.


<a id="orgb7e8fa7"></a>

### `/home-manager`

This directory contains home-manager user configuration.


<a id="org29d536f"></a>

### `/modules`

This directory contains custom NixOS modules.


<a id="org3bb6150"></a>

### `/plugables`

This directory contains reusable snippets of configuration.


<a id="orgfc5eabe"></a>

### `/pkgs`

This directory contains custom Nix pkg descriptions.

1.  `pkgs/unused`

    This directory contains custom Nix pkg descriptions that are not currently in use.


<a id="org2e77fcc"></a>

### `/env`

This directory contains build instructions for development environments. They should usually be sorted by language and given descriptive names.


<a id="org04fa0e5"></a>

### `/sources`

This directory contains files related to my automatic system for transparently managing external Nix sources such as nixpkgs.
It is unnecessary complicated and needs to be majorly improved and well-documented before being useful to the public.


<a id="orge4956d4"></a>

### `/files`

This directory contains miscellaneous files needed for various parts of my NixOS workflow. They should be individually documented.


<a id="org0cc54ac"></a>

## Additional


<a id="orgc4cb4f8"></a>

### TODO incorporate nix-get


<a id="org525beb8"></a>

### TODO `/images` tools


<a id="org517d537"></a>

### TODO explain all in `/files`
