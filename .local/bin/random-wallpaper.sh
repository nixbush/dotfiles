#!/usr/bin/env bash
wall_path="$HOME/Pictures/Wallpapers/$1"
wall_file=`file --mime-type $wall_path/* | grep 'image' | sed 's/:.*//' | shuf -n 1`
swww init &> /dev/null
swww img --transition-duration 1 "$wall_file"
