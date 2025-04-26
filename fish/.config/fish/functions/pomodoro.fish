# Requires https://github.com/caarlos0/timer to be installed.

function pomodoro
    set -l val $argv[1]
    if test -n "$val"
        if contains $val work break
            if type -q lolcat
                echo $val | lolcat
            else
                echo $val
            end

            timer (switch $val
                case work
                    echo 45m
                case break
                    echo 0.01m
            end)

            if type -q espeak
                espeak "'$val'  session done"
            end
        end
    end
end

