# Variables

ssh_user := "root"
systems_file := "deploy.nix"
nix_path := "nixpkgs=/etc/nixos/nixos-config/sources/links/nixos-unstable"

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

update:
	nix flake update --recreate-lock-file
	bash ./files/link.sh

update-pkgs:
	parallel --timeout 60 --bar update-nix-fetchgit ::: pkgs/*/*.nix

# Export

export SSH_USER := ssh_user
export NIX_PATH := ""
