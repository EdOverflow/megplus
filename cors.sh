#!/bin/bash

urlsfile=$1

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
END='\033[0m'

CORS=()
CREDS=()

if [ -z "$urlsfile" ]; then
    echo "Usage: $0 <urlsfile>"
    exit 1
fi

function checkacao {
    local url=$1
    local origin=$2

    curl -vs "$url" -H"Origin: $origin" 2>&1 | grep -i "< Access-Control-Allow-Origin: $origin" &> /dev/null
}

function checkacac {
    local url=$1
    local origin=$2

    curl -vs "$url" -H"Origin: $origin" 2>&1 | grep -i "< Access-Control-Allow-Credentials: true" &> /dev/null
}

while read url; do
    domain=$(echo "$url" | sed -r 's#https?://([^/]*)/?.*#\1#')

    for origin in https://evil.com null https://$domain.evil.com https://${domain}evil.com; do
        if checkacao $url $origin; then
            CORS+=("$url might be vulnerable with origin '$origin'")
            if checkacac $url $origin; then           
                CREDS+=("$url with origin '$origin' has Allow-Credentials: true")
            fi
        fi
        sleep 2
    done
done < $urlsfile

if [[ ${#CORS[@]} -gt 0 ]]; then
	printf "${YELLOW}[i]${END} Potentially vulnerable targets:\\n"
	printf '%s\n' "${CORS[@]}"
fi
if [[ ${#CREDS[@]} -gt 0 ]]; then
	printf "${YELLOW}[i]${END} Has 'Allow-Credentials: true':\\n"
	printf '%s\n' "${CREDS[@]}"
fi