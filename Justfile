# Variables

ssh_user := "root"
systems_file := "deploy.nix"
nix_path := "nixpkgs=/etc/nixos/links/nixpkgs"

# Commands

build +machines:
	./files/deploy.sh build {{machines}}

deploy +machines:
	./files/deploy.sh switch {{machines}}

secrets:
	just secrets/default

update:
	nix flake update

update-pkgs:
	parallel --timeout 60 --progress update-nix-fetchgit ::: pkgs/*/*.nix

# Export

export SSH_USER := ssh_user
export NIX_PATH := ""
