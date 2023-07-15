#!/usr/bin/sh

TERMINAL="alacritty --embed 0x --hold -e sh -c "

declare -a options=(

"ffplay"
"echo hello"
"quit"
)


choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 10 -p "Tools ")

if [[ "$choice" == quit ]]; then
	echo "Program Terminated." && exit 1
elif [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$BROWSER "$cfg"
else
	echo "Program Terminated." && exit 1
fi
