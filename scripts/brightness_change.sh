#!/bin/sh

case $1 in

# Increase Brightness
    -i)
	brightnessctl set +5%
#	herbe "$(brightnessctl g)"
#	sleep 1
#	pkill -SIGUSR1 herbe
    	;;

# Decrease Brightness
    -d)
	brightnessctl set 5%-
#	herbe "$(brightnessctl g)"
# 	sleep 1
#	pkill -SIGUSR1 herbe

    	;;
esac
