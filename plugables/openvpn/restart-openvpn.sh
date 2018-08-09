#!/usr/bin/env bash
LIST=`systemctl list-unit-files | grep -o '^openvpn[^ ]*'`
for SERVICE in $LIST; do
	STATUS=`systemctl is-active "$SERVICE"`
	if [[ $STATUS == "active" ]]; then
		echo "Restarting: $SERVICE"
		systemctl restart "$SERVICE"
		exit 0
	fi
done
