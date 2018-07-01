#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
END='\033[0m'

if [[ $1 == '' ]] || [[ $1 == '-h' ]] || [[ $1 == '--help' ]]; then
	echo "1) Usage - target list of domains:        ./megplus.sh <list of domains>"
	echo "2) Usage - target all HackerOne programs: ./megplus.sh -x <H1 X-Auth-Token>"
	echo "3) Usage - run Sublist3r first against host:           ./megplus.sh -s <single host>"
	echo
	echo "1) Example: ./megplus.sh domains"
	echo "2) Example: ./megplus.sh -x XXXXXXXXXXXXXXXX"
	echo "3) Example: ./megplus.sh -s example.com"
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
	"ᕕ( ᐕ )ᕗ"
	"三三ᕕ( ᐛ )ᕗ"
	"ᐠ( ᐛ )ᐟ"
	"Never gonna give you up."
	"Bounty pls."
	"Update pls."
	"Sleep is for the weak."
	"Grab a cuppa!"
	"meg+, meg on steroids."
	"I am 100 percent natural."
	"A bug is never just a mistake. It represents something bigger. An error of thinking that makes you who you are."
	"You hack people. I hack time."
	"I hope you don't screw like you type."
	"Hack the planet!"
	"Crypto stands for cryptography."
	"PoC||GTFO"
)

rand=$((RANDOM % ${#QUOTES[@]}))
printf "${YELLOW}[i]${END} ${QUOTES[$rand]}\\n"
echo

if ! which meg &> /dev/null; then 
	echo "You need to install meg."
	echo "Follow the installation instructions found here: https://github.com/tomnomnom/meg#install"
	exit 1
fi

if [[ $1 == '-x' ]] && [[ $2 != '' ]]; then
	printf "${GREEN}[+]${END} Fetching all in-scope targets.\\n"
	php fetch.php "$2" > temp
	cat temp | sed -E 's#https?://##I' | sed -E 's#/.*##' | sed -E 's#^\*\.?##' | sed -E 's#,#\n#g' | tr '[:upper:]' '[:lower:]' | uniq | sed -e 's/^/https:\/\//' > domains-plus
	targets="domains-plus"
	# gio trash temp
elif [[ $1 == '-s' ]] && [[ $2 != '' ]]; then
	printf "${GREEN}[+]${END} Running Sublist3r against $2.\\n"
	# Set Sublist3r path here!
	python Sublist3r/sublist3r.py -d "$2" -o domains-sub > /dev/null
	while read -r domain; do 
		if host "$domain" > /dev/null; then 
			echo "$domain"; 
		fi;
	done < domains-sub >> output
	cat output | sed -E 's#https?://##I' | sed -E 's#/.*##' | sed -E 's#^\*\.?##' | sed -E 's#,#\n#g' | tr '[:upper:]' '[:lower:]' | uniq | sed -e 's/^/https:\/\//' > domains-plus
	targets="domains-plus"
	echo
else
	cat "$1"" | sed "-E 's#https?://##I' | sed -E 's#/.*##' | sed -E 's#^\*\.?##' | sed -E 's#,#\n#g' | tr '[:upper:]' '[:lower:]' | uniq | sed -e 's/^/https:\/\//' > "$1-plus"
	targets="$1-plus"
fi

printf "${GREEN}[+]${END} Finding configuration files.\\n"
meg --delay 100 lists/configfiles "$targets" &>/dev/null
grep -Hnri "200 ok" out/
echo

printf "${GREEN}[+]${END} Finding interesting strings.\\n"
./findstrings.sh out/
echo

printf "${GREEN}[+]${END} Finding AWS/DigitalOcean/Azure buckets.\\n"
./findbuckets.sh out/
echo

printf "${GREEN}[+]${END} Finding open redirects.\\n"
meg --delay 100 lists/openredirects "$targets" &>/dev/null
grep --color -HnriE '< location: (https?:)?[/\\]{2,}example.com' out/
echo

printf "${GREEN}[+]${END} Finding CRLF injection.\\n"
meg --delay 100 lists/crlfinjection "$targets" &>/dev/null
grep --color -HnriE "< Set-Cookie: ?crlf"
echo

printf "${GREEN}[+]${END} Finding CORS misconfigurations.\\n"
./cors.sh "$targets"
echo

printf "${GREEN}[+]${END} Finding path-based XSS.\\n"
meg /bounty%3c%22pls "$targets"
grep --color -Hrie '(bounty<|"pls)' out/
echo

printf "${GREEN}[+]${END} Searching for (sub)domain takeovers.\\n"
./findtakeovers.sh
echo

printf "${GREEN}[+]${END} Running waybackurls.\\n"
cat "$targets" | waybackurls > out/urls
printf "${YELLOW}[i]${END} Output in './out/urls' file.\\n"
echo

# You can use gvfs-trash too.
# gio trash output
# gio trash domains-plus
# gio trash domains-sub
printf "${YELLOW}[i]${END} Done scanning -- all output located in ./out.\\n"

echo """
          _,-.     --------------------
  ,-. ,--'  o ) -(   Frogs find bugs!   )
  \(,' '  ,,-'     --------------------
 ,-.\-.__,\\\_
 \('--'    '\ 
"""
