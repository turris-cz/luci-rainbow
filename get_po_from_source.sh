#!/bin/sh

if [ $# -ne 1 ]; then
	echo "ERROR: specify input source code."
	exit 1
fi

SRC_FILE="$1"

sed -n 's/.*translatef*("\([^"]*\)".*/msgid "\1"@@@msgstr ""@@@/p' $SRC_FILE | \
sort | \
uniq | \
sed 's/@@@/\n/g'
