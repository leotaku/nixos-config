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

collect-garbage time="100j":
	nix-collect-garbage --delete-older-than "{{time}}"

update:
	./sources/update.sh

# Export

export SSH_USER := ssh_user
