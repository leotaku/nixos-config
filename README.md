# nixos-config
A git repository to store my nix configurations in

!!! DESCRIPTION OUTDATED !!!

## Idea
System configurations in this github repo are intended to be "installable" by linking any .nix file stored in the top level directory to `/etc/nixos/configuration.nix`. .nix files for machine, user, dotfile, etc. configurations should be stored in separate directories containing only other files configuring their one aspect of the system. These directories should also not contain other directories that contain files of other configuration-types. (eg. no "/users/dotfiles", but "/users" and "/dotfiles")

## File structure

### Top level
.nix files in this directory are intended to be linked to `/etc/nixos/configuration.nix` to provide a full nixos configuration. They should generally only contain imports from other files. They are to be labeled according to their purpose in the following format: `<usage>-<machine>-<user/group>.nix`
Example: `home-thinkpad-leo.nix`

### Systems
.nix files in this directory should contain system-wide configurations. 

### Machines
.nix files in this directory should generally contain the results of the hardware scan, as well as, if possible, options that are directly related to specific NixOS installs. (eg. bootloader options)

### Users
.nix files in this directory should contain configurations for individual users, they should not depend on any specific systems. Ideally all configurations in this directory should be managed through a user-configuration NixOS module (eg. nixup, home-manager), however none of these tools currently cover everything I need, which leads to some system-wide configurations having to be set.

### Groups
.nix files in this directory are used for importing different users into one file on multi-user systems. Top level .nix files on those systems should then import these files instead of multiple user files.

### Dotfiles
This directory should contain non-.nix files for configuring different programmes. The configurations set here are only to be applied after a system rebuild. The files in this directory should be grouped by users folders containing arbitrary folders and files. 

### Env (bad name)
This directory may contain arbitrary folders containing build instructions for development environments. They should usually be sorted by language and given descriptive names.

## Additional Info
Top level configuaration files should import systems, machines/hardware and users separately. Systems should not import users or hardware.
