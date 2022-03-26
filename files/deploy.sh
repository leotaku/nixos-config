#!/usr/bin/env sh
set -e
action="$1"
shift

for machine in "${@}"; do
    echo "Building machine ${machine}..."

    host="nixos-${machine}.local"
    if [ "$host" == "$(hostname).local" ]; then
        sudo nixos-rebuild "$action"  \
                 --flake .#"$machine" \
                 --no-build-nix       \
                 --use-substitutes
    else
        nixos-rebuild "$action"  \
            --flake .#"$machine" \
            --no-build-nix       \
            --use-substitutes    \
            --target-host root@"$host" \
            --build-host  root@"$host"
    fi
done
