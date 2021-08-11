#!/usr/bin/env sh
set -e
action="$1"
shift

for machine in "${@}"; do
    ssh_target="root@nixos-${machine}.local"
    echo "Building machine ${machine}..."
    nixos-rebuild "$action" --flake .#"$machine" \
                  --target-host "$ssh_target" \
                  --build-host "$ssh_target"
done
