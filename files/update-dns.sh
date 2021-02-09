#!/usr/bin/env bash
set -e

# Functions
get-records() {
    curl -X GET "https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE}/dns_records" \
      -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
      -H "X-Auth-Key: $CLOUDFLARE_KEY" \
      -H "Content-Type: application/json" 2>/dev/null
}

update-record() {
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE}/dns_records/${id}" \
      -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
      -H "X-Auth-Key: $CLOUDFLARE_KEY" \
      -H "Content-Type: application/json" \
      --data "$json" 2>/dev/null
}

# Get records
RESPONSE="$(get-records)"
LINES="$(jq -c '.result | .[]' <<<"$RESPONSE")"
OLD_IP="$(jq -r '.result | .[0] | .content' <<<"$RESPONSE")"
NEW_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

# Check if IP used by Cloudflare is outdated
if [[ "$OLD_IP" == "$NEW_IP" ]]; then
    echo "No update needed: $NEW_IP"
    exit
fi

# Update records
while read -r json; do
    type="$(jq -r '.type' <<<"$json")"
    if [[ "A" == "$type" ]]; then
        id="$(jq -r '.id' <<<"$json")"
        json="$(jq --arg c "$NEW_IP" -c '.content = $c' <<<"$json")"
        update-record | jq -c
    fi
done <<< "$LINES"
