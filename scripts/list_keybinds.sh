#!/bin/bash

usage() {
    echo "Usage: list_keybinds.sh [-h|--help] [-a|--all] [-t|--terminal]"
}

case "$1" in
    -h|--help)
    usage
    ;;

    -a|--all)
    keybinds="
Super-f:              Browser
Super-v:              Audio
Super-c:              VS Code
Alt-Shift-a:          ArchWiki
Alt-Shift-b:          Bookmarks
Ctrl-Alt-t:           Terminal
Ctrl-Shift-esc:       Task Manager
Super-grave:          Rofi
Alt-hash:             Network Manager
Ctrl-print:           Flameshot
Super-w:              Random Wallpaper
Super-n:              Monitor off
Super-m:              Monitor on

Alt-p:                Dmenu
Alt-b:                Toggle Bar
Alt-j:                Focus Next Window
Alt-k:                Focus Previous Window
Alt-Shift-j:          Move Window Down
Alt-Shift-k:          Move Window Up
Alt-Shift-h:          Increase Window Size
Alt-Shift-l:          Decrease Window Size
Alt-Shift-Return:     Swap Focused Window with Master Window
Alt-Tab:              Toggle Between Two Most Recent Tags
Alt-0:                View All Tags
Alt-number:           View Tag Number
Alt-Shift-number:     Tag Focused Window with Tag Number
Alt-Shift-comma:      Send Focused Window to Previous Screen
Alt-Shift-period:     Send Focused Window to Next Screen
Alt-Shift-c:          Close Focused Window
Alt-f:                Toggle Floating Mode
Alt-t:                Toggle Tiling Mode
Alt-m:                Toggle Monocle Mode
Alt-Shift-q:          Quit DWM"

    selected=$(echo "$keybinds" | dmenu -l 30 -p "Choose a keybinding:")
    case "$selected" in
        Super-f)  echo "browser" ;;
        Super-v)  echo "audio" ;;
        Super-c)  echo "VS Code" ;;
        Alt-Shift-a)  echo "archWiki" ;;
        Alt-Shift-b)  echo "bookmarks" ;;
        Ctrl-Alt-t)  echo "terminal" ;;
        Ctrl-Shift-esc)  echo "task manager" ;;
        Super-grave)  echo "rofi" ;;
        Alt-hash)  echo "network manager" ;;
        Ctrl-print)  echo "flameshot" ;;
        Super-w)  echo "random wallpaper" ;;
        Alt-p)  echo "dmenu" ;;
        Alt-b)  echo "toggle bar" ;;
        Alt-j)  echo "focus next window" ;;
        Alt-k)  echo "focus previous window" ;;
        Alt-Shift-j)  echo "move window down" ;;
        Alt-Shift-k)  echo "move window up" ;;
        Alt-Shift-h)  echo "increase window size" ;;
        Alt-Shift-l)  echo "decrease window size" ;;
        Alt-Shift-Return)  echo "swap focused window with master window" ;;
        Alt-Tab)  echo "toggle between two most recent tags" ;;
        Alt-0)  echo "view all tags" ;;
        Alt-number)  echo "view tag number" ;;
        Alt-Shift-number)  echo "tag focused window with tag number" ;;
        Alt-Shift-c)  echo "close focused window" ;;
        Alt-f)  echo "toggle floating mode" ;;
        Alt-t)  echo "toggle tiling mode" ;;
        Alt-m)  echo "toggle monocle mode" ;;
        Alt-Shift-q)  echo "quit dwm" ;;
        *)  echo "Unknown keybinding" ;;
    esac
    ;;

    -t|--terminal)
    echo "Keybind:              Action:"
    echo "-----------------     -----------------"
    awk '/^\s*[A-Za-z0-9-]+:/ { keybind = $1; $1 = ""; action = $0; gsub(/^[ \t]+/, "", action); printf("%-21s %s\n", keybind, action); }' "$0" | grep -vE '^ *echo |^ *grep |^ *awk '
    ;;

    *)
    usage
    ;;
esac

