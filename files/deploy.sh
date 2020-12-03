#!/usr/bin/env sh
set -e
MACHINE="$1"
ACTION="$2"
SSH_TARGET="root@nixos-${MACHINE}.local"
ATTRIBUTE="nixosConfigurations.${MACHINE}.config.system.build.toplevel"
mkdir -p ".gc-roots"

echo "Building machine ${MACHINE}..."
nix build .#"$ATTRIBUTE" --out-link .gc-roots/"$MACHINE"
nix copy --to ssh://"$SSH_TARGET" .#"$ATTRIBUTE"
nixos-rebuild "$ACTION" --flake .#"$MACHINE" --target-host "$SSH_TARGET"
