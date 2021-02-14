#!/bin/sh
# WSL PowerShell Music Player Initialization Script
# Created By: Mushfiq Mahmud
# February 2021
# IMPORANT NOTE: Currently the script does not work with filenames
# containing whitespace.

# Check whether file was provided, otherwise terminate
if [ $# -eq 0 ]
then
	echo "Please provide an mp3 file"
	exit 1
fi

# Kill any previous session
pkill powershell.exe

# Get duration of song passed in as argument
duration=$(exiftool $1 | grep Duration | sed 's/^.*\([0-9]\+:[0-9]\+:[0-9]\+\).*$/\1/g')

# Extract hours, minutes and seconds from duration
hr=$(echo $duration | cut -d : -f 1)
mn=$(echo $duration | cut -d : -f 2)
sc=$(echo $duration | cut -d : -f 3)

# Calculate total seconds and add padding to ensure song finishes
padding=5
seconds=$(( 3600 * $hr + 60 * $mn + $sc + $padding ))

# Format song for windows filepath
song="\"$(realpath $1 | sed 's/\//\\/g' | sed 's/\\mnt\\\(c\)\\/\U\1:\\/g')\""

# Write song info to file
artist=$(mid3v2 $1 | grep TPE1 | sed 's/TPE1=\(.*\)/\1/g')
title=$(mid3v2 $1 | grep TIT2 | sed 's/TIT2=\(.*\)/\1/g')
echo "$artist - $title" > now-playing.txt

# Initiate powershell script in background
powershell.exe ./player.ps1 $song $seconds > /dev/null 2>&1 & echo $! > run.pid

