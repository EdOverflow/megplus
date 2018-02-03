#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
END='\033[0m'

if [[ $1 == '' ]] || [[ $1 == '-h' ]] || [[ $1 == '--help' ]]; then
	echo "Usage:   ./megplus.sh <list of domains>"
	echo "Usage:   ./megplus.sh -x <H1 X-Auth-Token>"
	echo "Example: ./megplus.sh domains"
	echo "Example: ./megplus.sh -x XXXXXXXXXXXXXXXX"
	exit 1
fi

echo -e """${CYAN}                                            
                                                                          
   88888b.d88b.   .d88b.   .d88b.    888   
   888  888  88b d8P  Y8b d88P 88b 8888888 
   888  888  888 88888888 888  888   888   
   888  888  888 Y8b.     Y88b 888         
   888  888  888   Y8888    Y88888         
                               888         
   ${GREEN}Automate meg${END}           ${CYAN}Y8b d88P${END}
   ${GREEN}By TomNomNom${END}            ${CYAN}YYY88P${END}          
   ${GREEN}& EdOverflow${END}
"""

QUOTES=(
	"Activating 1337 mode!"
	"Target uses Equifax-grade security."
	"ᕕ( ᐛ )ᕗ"
	"Never gonna give you up."
	"Bounty pls."
	"Update pls."
	"Sleep is for the weak."
	"Grab a cuppa!"
	"meg+, meg on steroids."
	"I am 100% natural."
	"A bug is never just a mistake. It represents something bigger. An error of thinking that makes you who you are."
	"You hack people. I hack time."
	"I hope you don't screw like you type."
	"Hack the planet!"
)

rand=$[RANDOM % ${#QUOTES[@]}]
printf "${YELLOW}[i]${END} ${QUOTES[$rand]}\\n"
echo

if [[ $1 == '-x' ]] && [[ $2 != '' ]]; then
	printf "${GREEN}[+]${END} Fetching all in-scope targets.\\n"
	php fetch.php $2 > temp
	cat temp | sed -r 's#https?://##I' | sed -r 's#/.*##' | sed -r 's#^\*\.?##' | sed -r 's#,#\n#g' | tr '[:upper:]' '[:lower:]' | uniq | sed -e 's/^/https:\/\//' > domains
	gio trash temp
	$1="domains"
fi

printf "${GREEN}[+]${END} Finding configuration files.\\n"
meg --delay 100 lists/configfiles $1 &>/dev/null
grep -Hnri "200 ok" out/
echo

printf "${GREEN}[+]${END} Finding interesting strings.\\n"
./findstrings.sh out/
echo

printf "${GREEN}[+]${END} Finding open redirects.\\n"
meg --delay 100 lists/openredirects $1 &>/dev/null
grep --color -HnriE '< location: (https?:)?[/\\]{2,}example.com' out/
echo

printf "${GREEN}[+]${END} Finding CRLF injection.\\n"
meg --delay 100 lists/crlfinjection $1 &>/dev/null
grep --color -HnriE "< Set-Cookie: ?crlf"
echo

printf "${GREEN}[+]${END} Finding CORS misconfigurations.\\n"
./cors.sh $1
echo

printf "${GREEN}[+]${END} Finding path-based XSS.\\n"
meg /bounty%3c%22pls $1
grep --color -Hrie '(bounty<|"pls)' out/
echo

printf "${GREEN}[+]${END} Searching for (sub)domain takeovers.\\n"
./findtakeovers.sh
echo

printf "${GREEN}[+]${END} Running waybackurls.\\n"
cat $1 | waybackurls > out/urls
printf "${YELLOW}[i]${END} Output in './out/urls' file.\\n"
echo

printf "${YELLOW}[i]${END} Done scanning -- all output located in ./out.\\n"

echo """
          _,-.     --------------------
  ,-. ,--'  o ) -(   Frogs find bugs!   )
  \(,' '  ,,-'     --------------------
 ,-.\-.__,\\\_
 \('--'    '\ 
"""
