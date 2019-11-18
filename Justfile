# Variables

ssh_user := "root"
systems_file := "deploy.nix"

# Commands

build glob="*":
	cd deployments; \
	morph build "{{systems_file}}" --on="{{glob}}" --keep-result

deploy glob="*":
	cd deployments; \
	morph deploy "{{systems_file}}" switch --on="{{glob}}" --keep-result

secrets glob="*":
	cd deployments; \
	morph upload-secrets "{{systems_file}}" --on="{{glob}}"

collect-garbage time="100j":
	nix-collect-garbage --delete-older-than "{{time}}"

update:
	./sources/update.sh

rebuild command nixpkgs="/etc/nixos/nixos-config/sources/links/nixos-unstable":
	nixos-rebuild "{{command}}" -I "nixpkgs={{nixpkgs}}"

# Export

export SSH_USER := ssh_user
export NIX_PATH := ""
