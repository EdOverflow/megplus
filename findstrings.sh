#!/bin/bash
searches=(
    '\-----BEGIN PRIVATE KEY-----'
    '\-----BEGIN RSA PRIVATE KEY-----'
    '$1$'
    'md5'
    '$5$'
    '$6$'
    '$2a$'
    '$2x$'
    '$2y$'
    '$2b$'
    'secret'
    'api_key'
    'api-key'
    'api_secret_key'
    'api-secret-key'
    'secret_key'
    'secret-key'
    'private_key'
    'private-key'
)

for str in "${searches[@]}"; do
    grep --color -Hnri "$str" out/
done