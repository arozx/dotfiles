function pom
    set split $POMO_SPLIT
    if ! test -n "$split"
        set split $(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")
    end

    switch $split
        case 25/5
            set work 25m
            set break 5m
        case 50/10
            set work 50m
            set break 10m
        case 'all done' ''
            return
    end

    timer $work && notify-send "Pomodoro" "Work Timer is up! Take a Break 😊"

    gum confirm "Ready for a break?" && timer $break && notify-send "Pomodoro" "Break is over! Get back to work 😬" \
        || pom
end
