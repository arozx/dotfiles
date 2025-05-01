# General
alias c="clear"
alias e=exit
alias nf="fastfetch"
alias pf="fastfetch"
alias ff="fastfetch"
alias l="eza -lah -a --icons=always"
alias ls="eza -a --icons=always"
alias ll="eza -al --icons=always"
alias lt="eza -a --tree --level=1 --icons=always"
alias shutdown="systemctl poweroff"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias wifi="nmtui"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gfo="git fetch origin"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# Pomodoro
alias pwork="pomodoro work"
alias wo="pomodoro work"
alias pw="pomodoro work"
alias pbreak="pomodoro break"
alias br="pomodoro break"
alias pb="pomodoro break"

# Scripts
alias dev-workspace="/home/glitch/scripts/tmux/dev-workspace.fish"

# Display
alias res1="xrandr --output HDMI-A-1 --mode 1920x1080 --rate 60"
alias res1="xrandr --output HDMI-A-1 --mode 2560x1440 --rate 120"

# Misc
alias pamcan=powerpill
alias keygh="eval (ssh-agent -c) && ssh-add ~/.ssh/github"
