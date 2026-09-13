#!/usr/bin/fish

set color_info (set_color cyan)
set color_success (set_color green)
set color_error (set_color red)
set color_reset (set_color normal)

set config_home "$HOME/.config"
if set -q XDG_CONFIG_HOME
    set config_home "$XDG_CONFIG_HOME"
end

set config_file "$config_home/tmux-remote/config.fish"

if test -f "$config_file"
    source "$config_file"
end

if not set -q tmux_remote_kitten_directives
    set tmux_remote_kitten_directives delegate=ssh
end

function require_command
    set -l command_name $argv[1]
    set -l package_name $argv[2]

    if not command -v $command_name > /dev/null
        printf "%s[ERROR]%s %s is not installed. Please install %s first.\n" $color_error $color_reset $command_name $package_name
        exit 1
    end
end

function is_enabled
    set -l value $argv[1]

    test "$value" = 1 -o "$value" = true -o "$value" = yes -o "$value" = on
end

function remote_picker_bindings
    set -l bindings \
        ctrl-d:half-page-down \
        ctrl-u:half-page-up

    if set -q tmux_remote_vim_menu_navigation
        if is_enabled "$tmux_remote_vim_menu_navigation"
            set -a bindings \
                j:down \
                k:up \
                h:half-page-up \
                l:half-page-down \
                g:top
        end
    end

    string join , $bindings
end

function emit_ssh_config_hosts
    set -l config_paths "$HOME/.ssh/config"
    for path in "$HOME/.ssh/conf.d"/* "$HOME/.ssh/config.d"/*
        if test -f "$path"
            set -a config_paths "$path"
        end
    end

    for config_path in $config_paths
        if not test -f "$config_path"
            continue
        end

        awk '
            BEGIN { IGNORECASE = 1 }
            /^[[:space:]]*Host[[:space:]]+/ {
                for (i = 2; i <= NF; i++) {
                    host = $i
                    if (host !~ /[*!?%]/) {
                        print host
                    }
                }
            }
        ' "$config_path" | while read --line host
            printf "ssh\t%s\t%s\n" "$host" "$host"
        end
    end
end

function emit_tailscale_hosts
    if not command -v tailscale > /dev/null
        return
    end

    if command -v jq > /dev/null
        tailscale status --json 2>/dev/null | jq -r '
            .Peer[]
            | select(.Online == true)
            | [
                "tailscale",
                (.DNSName // .HostName | sub("[.]$"; "")),
                (.DNSName // .HostName | sub("[.]$"; ""))
              ]
            | @tsv
        ' 2>/dev/null
    else
        tailscale status 2>/dev/null | awk '
            $1 ~ /^[0-9]+\./ && $2 != "" && $NF != "offline" {
                print "tailscale\t" $2 "\t" $2
            }
        '
    end
end

function switch_or_attach
    set -l session_name $argv[1]

    if set -q TMUX
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    end
end

function configured_user_for
    set -l target $argv[1]
    set -l label $argv[2]

    if set -q tmux_remote_user_map
        for entry in $tmux_remote_user_map
            set -l parts (string split --max 1 = "$entry")
            if test (count $parts) -ne 2
                continue
            end

            if test "$parts[1]" = "$target" -o "$parts[1]" = "$label"
                printf "%s\n" "$parts[2]"
                return
            end
        end
    end

    if set -q tmux_remote_default_user
        printf "%s\n" "$tmux_remote_default_user"
    end
end

function choose_ssh_user
    set -l suggested_user $argv[1]

    if not set -q tmux_remote_prompt_user
        set tmux_remote_prompt_user 1
    end

    if test "$tmux_remote_prompt_user" = 0 -o "$tmux_remote_prompt_user" = false
        printf "%s\n" "$suggested_user"
        return
    end

    if test -n "$suggested_user"
        read --prompt-str "SSH user [$suggested_user, '-' for none]: " selected_user

        if test -z "$selected_user"
            set selected_user "$suggested_user"
        end
    else
        read --prompt-str "SSH user ['-' for none]: " selected_user
    end

    printf "%s\n" "$selected_user"
end

function kitten_ssh_command
    set -l ssh_target $argv[1]
    set -l command_parts kitten ssh

    for directive in $tmux_remote_kitten_directives
        set -a command_parts --kitten "$directive"
    end

    set -a command_parts "$ssh_target"
    string escape -- $command_parts | string join ' '
end

require_command tmux tmux
require_command sk "skim (sk)"
require_command kitten "kitty kitten"

set selected (begin
    emit_ssh_config_hosts
    emit_tailscale_hosts
end | sort -u -k2,2 | sk \
    --bind (remote_picker_bindings) \
    --height 80% \
    --layout=reverse \
    --border \
    --prompt='remote> ' \
    --header='Select a device from SSH config or online Tailscale peers' \
    --delimiter='\t' \
    --with-nth=2,1)

if test -z "$selected"
    printf "%s[INFO]%s No device selected. Exiting.\n" $color_info $color_reset
    exit 0
end

set source (string split \t "$selected")[1]
set label (string split \t "$selected")[2]
set target (string split \t "$selected")[3]
set ssh_user (choose_ssh_user (configured_user_for "$target" "$label"))

if test -n "$ssh_user" -a "$ssh_user" != "-"
    set ssh_target "$ssh_user@$target"
else
    set ssh_target "$target"
end

set safe_target (string replace -ra '[^A-Za-z0-9_]+' '_' "$ssh_target" | string trim -c '_')
set session_name "remote_$safe_target"
set window_name (string sub --length 32 "$ssh_target")

tmux has-session -t "$session_name" 2>/dev/null

if test $status -ne 0
    set ssh_cmd (kitten_ssh_command "$ssh_target")
    tmux new-session -d -s "$session_name" -n "$window_name"
    tmux send-keys -t "$session_name:1" "$ssh_cmd" C-m
    printf "%s[SUCCESS]%s Created tmux session '%s' for %s device '%s'.\n" $color_success $color_reset $session_name $source $ssh_target
else
    printf "%s[INFO]%s Session '%s' already exists.\n" $color_info $color_reset $session_name
end

switch_or_attach "$session_name"
