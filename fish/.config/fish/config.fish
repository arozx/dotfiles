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

alias pamcan=powerpill

alias l="ls -lah"

alias v=nvim
alias vi=nvim
alias vim=nvim

alias gs="git status"
alias gpush="git push"
alias gpull="git pull"
alias gc="git commit"

alias e=exit
alias c=clear

alias keygh="eval (ssh-agent -c) && ssh-add ~/.ssh/github"

alias dev-workspace='/home/glitch/scripts/tmux/dev-workspace.fish'

set -U fish_user_paths $fish_user_paths ~/go/bin

# Start SSH agent if not running
status is-interactive; and not set -q SSH_AUTH_SOCK; and eval (ssh-agent -c)

oh-my-posh init fish | source
