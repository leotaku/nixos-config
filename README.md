
# Table of Contents

1.  [nixos-config](#org8d2c499)
    1.  [Idea](#orgc191403)
    2.  [Deploying](#orge6c1762)
        1.  [Local Systems](#org5d793ae)
        2.  [NixOps Deployments](#org9a14d51)
        3.  [NixOS Images](#orgf429429)
    3.  [File structure](#org00c0529)
        1.  [`/local`](#orgedeb08b)
        2.  [`/deployments`](#org966e8c8)
        3.  [`/hardware`](#org590bf22)
        4.  [`/home-manager`](#org1a20307)
        5.  [`/modules`](#org9c5d6d9)
        6.  [`/plugables`](#org7f9bfb0)
        7.  [`/pkgs`](#orgb4e1c1e)
        8.  [`/env`](#org9c3e79a)
        9.  [`/sources`](#orgd9c71ce)
        10. [`/files`](#org091aac0)
    4.  [Additional](#orgc75894f)
        1.  [incorporate nix-get](#orgc29ed69)
        2.  [`/images` tools](#org2742cf9)
        3.  [explain all in `/files`](#org3ce55a8)


<a id="org8d2c499"></a>

# nixos-config

A git repository to store my nix configurations in


<a id="orgc191403"></a>

## Idea

This repository contains the configurations for my NixOS systems, with end-user systems being stored in `/local` and NixOps deployments being stored in `/deploments`.

As soon as there are more than one end-user systems the file structure for them should be revised.


<a id="orge6c1762"></a>

## Deploying


<a id="org5d793ae"></a>

### Local Systems

New *"raw"* NixOS systems can be installed on an existing NixOS machine by first adding new system description to a subfolder in `/local`, creating a matching hardware configuration in `/hardware` and then linking the configuration to `/etc/nixos/configuration.nix`.

`REWORK PLANNED`

Deploy the current (only) system by running:

    ln -s ./local/configuration.nix /etc/nixos/configuration.nix
    
    sudo nixos-rebuild switch --install-bootloader


<a id="org9a14d51"></a>

### NixOps Deployments

Similarly NixOps deployments live in `/deployments`. Servers comprising a singular network should ideally all be contained in a single deployment (but may be split across multiple files). Hardware specific information should still always live in `/hardware`.

Create the current (only) deployment by running:

    nixops create -d combined $(pwd)/deployments/combined.nix

And deploy it using:

    nixops deploy -d combined -I "nixpkgs=./sources/links/nixpkgs/nixos-18_09-small"


<a id="orgf429429"></a>

### TODO NixOS Images


<a id="org00c0529"></a>

## File structure


<a id="orgedeb08b"></a>

### `/local`

This directory contains system descriptions intended for local (read non-NixOps) use. Possibly sorted in subdirs. `TO BE IMPLEMENTED`

The current structure is:

    /local/configuration.nix
    /local/system.nix
    /local/user.nix

with `/local/configuration.nix` intended to be symlinked to `/etc/nixos/configuration.nix`.


<a id="org966e8c8"></a>

### `/deployments`

This directory contains system deployments deployed using NixOps.


<a id="org590bf22"></a>

### `/hardware`

This directory contains the hardware dependent configuration of all local and deployed systems in this repository.


<a id="org1a20307"></a>

### `/home-manager`

This directory contains home-manager user configuration.


<a id="org9c5d6d9"></a>

### `/modules`

This directory contains custom NixOS modules.


<a id="org7f9bfb0"></a>

### `/plugables`

This directory contains reusable snippets of configuration.


<a id="orgb4e1c1e"></a>

### `/pkgs`

This directory contains custom Nix pkg descriptions.

1.  `pkgs/unused`

    This directory contains custom Nix pkg descriptions that are not currently in use.


<a id="org9c3e79a"></a>

### `/env`

This directory contains build instructions for development environments. They should usually be sorted by language and given descriptive names.


<a id="orgd9c71ce"></a>

### `/sources`

This directory contains files related to my automatic system for transparently managing external Nix sources such as nixpkgs.
It is unnecessary complicated and needs to be majorly improved and well-documented before being useful to the public.


<a id="org091aac0"></a>

### `/files`

This directory contains miscellaneous files needed for various parts of my NixOS workflow. They should be individually documented.


<a id="orgc75894f"></a>

## Additional


<a id="orgc29ed69"></a>

### TODO incorporate nix-get


<a id="org2742cf9"></a>

### TODO `/images` tools


<a id="org3ce55a8"></a>

### TODO explain all in `/files`

