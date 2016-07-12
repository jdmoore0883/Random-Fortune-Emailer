#! /bin/bash
##########################################################
# This script will randomly pick a cowsay "figure",
# pipe the fortune command in to it, and email it out.
#
# PREREQUISITS:
#       - mutt email client installed and configured
#       - cowsay binary
#       - fortune binary
##########################################################
#
# Written by: Jon Moore
#       jdmoore0883@gmail.com
#       jonmoore.duckdns.org
#
# Release 3 - Apr. 1, 2016 - bugfix - <! #2
# Release 2 - Mar. 11, 2016 - bugfix - <!
# Release 1 - Jan. 5, 2015 - Initial release
#
##########################################################

# Email addresses in format:
#       email1@email.com,email2@email.com,email3@email.com
EMAILS="email1@somewhere.com,email2@somewhere.com,email3@somewhere.com,email4@somewhere.com,email5@somewhere.com"

HTML_START="<!DOCTYPE html><html><body><pre style=font-family:\"Courier New\">"
HTML_END="</pre></body></html>"

# List all cowsay options
Options=$(/usr/games/cowsay -l)

# Remove the first line
PRE="Cow files in /usr/share/cowsay/cows: "
START=${#PRE}

# Put all the options into a list
Options2=${Options:START}
SPACE=' '; set -f
eval "LIST=(\$Options2)"

# Randomly pick one of the cowsay options
num_LIST=${#LIST[*]}
FINAL_OPTION=${LIST[$((RANDOM%num_LIST))]}

# Start peicing the HTML Fortune together
FINAL_FORTUNE=$HTML_START

# THE FORTUNE!
FORTUNE=$(/usr/games/fortune | /usr/games/cowsay -f $FINAL_OPTION)
# Replace <! (HTML Comment tag) with &lt;! , which will translate to <!
FORTUNE=$(echo "$FORTUNE" | sed "s/<\!/\&lt;\!/g")

# Finish the HTML Fortune
FINAL_FORTUNE+="$FORTUNE"
FINAL_FORTUNE+=$HTML_END

# Send the email
echo "$FINAL_FORTUNE" | mutt -e "set content_type=text/html" -s "Your Fortune!" -b $EMAILS

exit 0

# Generate a random number between 1 and 10 SPOTS=10 NUM=0 let "NUM = $RANDOM % $SPOTS +1" echo $NUM

