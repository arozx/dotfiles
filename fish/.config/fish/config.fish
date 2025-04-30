function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias l="ls -lah"
alias e=exit
alias c=clear

alias pamcan=powerpill

# Editor
alias v=nvim
alias vi=nvim
alias vim=nvim

# Git
alias gs="git status"
alias gpush="git push"
alias gpull="git pull"
alias gc="git commit"

alias keygh="eval (ssh-agent -c) && ssh-add ~/.ssh/github"

alias dev-workspace='/home/glitch/scripts/tmux/dev-workspace.fish'

# Pomodoro
alias pwork="pomodoro work"
alias pbreak="pomodoro break"

alias wo="pomodoro work"
alias br="pomodoro break"

set -U fish_user_paths $fish_user_paths ~/go/bin

# Start SSH agent if not running
if status is-interactive
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c) && ssh-add ~/.ssh/github
    end
end

oh-my-posh init fish | source

# pnpm
set -gx PNPM_HOME "/home/glitch/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
