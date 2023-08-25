#!/bin/bash
#
# This script changes the wallpaper

case $1 in
	-h|--help)
		echo "Usage: $0 [OPTION]..."
		echo "Changes the wallpaper."
		echo
		echo "  -h, --help		display this help and exit"
		echo "  -l, --list		list all available wallpapers"
		echo "  -r, --random		set a random wallpaper"
		;;

	-l|--list)
		ls -1 ~/wallpapers
		;;

	-r|--random)
		feh --bg-scale --randomize ~/wallpapers/
		;;

esac
