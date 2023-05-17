#!/bin/sh

case $1 in

# Increase volume
    -i)
    	pamixer -i 5 & herbe "$(pamixer --get-volume)"
	sleep 1
	pkill -SIGUSR1 herbe
    	;;

# Decrease volume.
    -d)
	pamixer -d 5 & herbe "$(pamixer --get-volume)"
	sleep 1
	pkill -SIGUSR1 herbe
	;;
esac
