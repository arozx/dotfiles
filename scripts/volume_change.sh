#!/bin/sh

case $1 in

# Increase volume
    -i)
        pamixer -i 5
	sleep 0.01
	herbe "$(pamixer --get-volume)"
	sleep 0.1
	pkill -SIGUSR1 herbe
    	;;

# Decrease volume.
    -d)
	pamixer -d 5
	sleep 0.01
	herbe "$(pamixer --get-volume)"
	sleep 0.1
	pkill -SIGUSR1 herbe
	;;

# Mute volume.
    -m)
    pamixer -t
    sleep 0.01
    herbe "$(pamixer --get-volume)"
    sleep 0.1
    pkill -SIGUSR1 herbe
    ;;	

esac
