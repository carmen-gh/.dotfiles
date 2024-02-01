#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title downloaded
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

DOWNLOADS="$HOME/Downloads"

RECENT=$(mdls -name kMDItemFSName -name kMDItemDateAdded ~/Downloads/* | \
sed 'N;s/\n//' | \
awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
sort -r | \
cut -d'"' -f2 | \
head -n1)

open -R "$DOWNLOADS/$RECENT"
#echo "${RECENT##*/}"

