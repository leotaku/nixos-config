# nixos-config
A git repository to store my nix configurations in

## Idea
System configurations stored in this github repo should be easily "installable" by linking any .nix file stored in the top level directory. Files for machine, user, dotfile, etc. configurations should be stored in separate folders containing only files configuring one aspect of the system. These directories should also not contain other directories that contain files of other configuration-types. (eg. no "/users/dotfiles", but "/users" and "/dotfiles")
## File structure
### Top level
.nix files in this directory should be linkable to /etc/nixos/configuration.nix they should generally only contain imports from other file. They are to be labeled according to their purpose in the following format:
 "<usage>-<system>-<users>.nix"
Example:
"home-thinkpad-leo.nix"
