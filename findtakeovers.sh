#!/bin/bash
searches=(
    "There is no app configured at that hostname"
    "NoSuchBucket"
    "No Such Account"
    "You're Almost There"
    "a GitHub Pages site here"
    "this shop is currently unavailable"
    "There's nothing here"
    "The site you were looking for couldn't be found"
    "The request could not be satisfied"
    "project not found"
    "Your CNAME settings"
    "The resource that you are attempting to access does not exist or you don't have the necessary permissions to view it."
    "Domain mapping upgrade for this domain not found"
    "The feed has not been found"
    "The requested URL / was not found on this server."
    "This UserVoice subdomain is currently available!"
)

for str in "${searches[@]}"; do
    grep --color -Hnri "$str" out/
done
