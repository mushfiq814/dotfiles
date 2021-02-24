#!/bin/sh

# get current mp3 file from mplayer
song=$(lsof -c mplayer | fgrep ".mp3" | awk -F " " '{ print $NF; }')

# Write song info to file
artist=$(mid3v2 $song | grep TPE1 | sed 's/TPE1=\(.*\)/\1/g')
title=$(mid3v2 $song | grep TIT2 | sed 's/TIT2=\(.*\)/\1/g')

echo "$artist - $title"


