# Default username offered after selecting a remote. Leave unset to prompt with
# no default, or enter '-' at the prompt to connect without a user prefix.
# set -g tmux_remote_default_user glitch

# Per-device defaults override tmux_remote_default_user. Match either the SSH
# config host alias or the Tailscale DNS/host name shown in the selector.
set -g tmux_remote_user_map \
    "inv-vps.tail19be.ts.net=opc"

#   "workstation=username"
#   "server.example.com=admin"

# Set to 0 to skip the username prompt and always use the configured default.
# set -g tmux_remote_prompt_user 1

# Enable Vim-style navigation in the remote picker. This maps j/k to down/up,
# h/l to half-page up/down, and g to top. Disable it if you prefer typing those
# letters into the fuzzy query.
set -g tmux_remote_vim_menu_navigation 1

# Extra kitten ssh directives. Because tmux can expose stale KITTY_PID and
# KITTY_WINDOW_ID values, use kitty's delegate mode by default inside tmux.
# This still invokes kitten ssh, but lets OpenSSH handle the actual session.
# set -g tmux_remote_kitten_directives delegate=ssh
