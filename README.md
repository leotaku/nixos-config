# nixos-config
A git repository to store my nix configurations in

## Idea
System configurations in this github repo are intended to be "installable" by linking any .nix file stored in the top level directory to `/etc/nixos/configuration.nix`. .nix files for machine, user, dotfile, etc. configurations should be stored in separate directories containing only other files configuring their one aspect of the system. These directories should also not contain other directories that contain files of other configuration-types. (eg. no "/users/dotfiles", but "/users" and "/dotfiles")
## File structure
### Top level
.nix files in this are intended to be linked to `/etc/nixos/configuration.nix` to provide a full nixos configuration. they should generally only contain imports from other files. They are to be labeled according to their purpose in the following format: `<usage>-<machine>-<users>.nix`
Example: `home-thinkpad-leo.nix`

### Systems
### Machines
### Users
### Dotfiles
