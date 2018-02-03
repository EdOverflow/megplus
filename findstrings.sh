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
)

for str in "${searches[@]}"; do
    grep --color -Hnri "$str" out/
done