#!/bin/sh

# Exit if any subcommand fails
set -e 

# Setup node modules if needed
if [ -e node_modules/.bin/html-validator ]; then
    setup=""
else
    echo "## Your environment is not ready yet. Installing modules..."
    if [ -f yarn.lock ]; then
        setup="yarn --non-interactive --silent --ignore-scripts --production=false &&"
    else
        setup="NODE_ENV=development npm install &&"
    fi
fi

echo "## Starting html-validator"

if [ -z "$1" ]; then
    echo "## Validating HTML files"
	sh -c '$setup 
			for filename in ${PWD}*.html; do
				echo ">> Filename : $filename"
	    		./node_modules/.bin/html-validator --file="$filename" --verbose || continue
			done';
else 
	echo "## Validating HTML for option $@"
    sh -c "$setup ./node_modules/.bin/html-validator $@ --verbose"
fi





