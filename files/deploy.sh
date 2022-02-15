#!/usr/bin/env sh
set -e
action="$1"
shift

for machine in "${@}"; do
    host="nixos-${machine}.local"
    if [ "$host" == "$(hostname).local" ]; then
        host="0.0.0.0"
    fi

    echo "Building machine ${machine}..."
    nixos-rebuild "$action"  \
        --flake .#"$machine" \
        --no-build-nix       \
        --use-substitutes    \
        --target-host root@"$host" \
        --build-host  root@"$host"
done
