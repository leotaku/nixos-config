#!/usr/bin/env sh
set -e
MACHINE="$1"
ACTION="$2"
SSH_TARGET="root@nixos-${MACHINE}.local"
ATTR="self#nixosConfigurations.${MACHINE}.config.system.build.toplevel"

echo "Building machine ${MACHINE}..."

if [ "$ACTION" = "build" ]; then
    nix build --print-build-logs --no-link "$ATTR"
else
    echo "Copying files to remote machine..."
    nix copy --to ssh://"$SSH_TARGET" "$ATTR"

    echo "Applying configuration..."
    STORE_PATH=$(nix path-info "$ATTR")
    ssh "$SSH_TARGET" "$STORE_PATH"/bin/switch-to-configuration "$ACTION"
fi
