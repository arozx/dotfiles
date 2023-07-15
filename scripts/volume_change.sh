#!/bin/sh

case $1 in

# Increase volume
    -i)
    	amixer sset Master 5%+
	sleep 0.01
	herbe "$(amixer sget Master)"
	sleep 0.3
	pkill -SIGUSR1 herbe
    	;;

# Decrease volume.
    -d)
	amixer sset Master 5%-
	sleep 0.01
	herbe "$(amixer sget Master)"
	sleep 0.3
	pkill -SIGUSR1 herbe
	;;
esac
