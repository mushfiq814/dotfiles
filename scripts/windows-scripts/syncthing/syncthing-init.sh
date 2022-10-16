#!/bin/sh

# path to syncthing init powershell script
syncthing='~/dotfiles/scripts/syncthing-init.ps1'

# Initiate powershell script in background
powershell.exe $syncthing > /dev/null 2>&1
