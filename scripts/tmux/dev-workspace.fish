#!/usr/bin/fish

# Define colors
set color_info (set_color cyan)
set color_success (set_color green)
set color_error (set_color red)
set color_reset (set_color normal)

# Define excluded paths
set excluded_paths \
    "node_modules" \
    "$HOME/.cache" \
    "$HOME/.npm" \
    "$HOME/.local" \
    "$HOME/.config" \
    "$HOME/.vscode" \
    "$HOME/.mozilla" \
    "$HOME/.rustup" \
    "$HOME/.cargo" \
    "$HOME/idea" \
    "$HOME/vaults" \
    "$HOME/go" \
    "$HOME/wallpapers" \
    "$HOME/Pictures" \
    "$HOME/Videos" \
    "$HOME/3d-printing" \
    "$HOME/books" \
    "$HOME/clion-2024.3.2"

# Check if tmux is installed
if not command -v tmux > /dev/null
    printf "%s[ERROR]%s tmux is not installed. Please install it first.\n" $color_error $color_reset
    exit 1
end

# Check if skim (sk) is installed
if not command -v sk > /dev/null
    printf "%s[ERROR]%s skim (sk) is not installed. Please install it first.\n" $color_error $color_reset
    exit 1
end

# Build find command with excluded paths and a max depth of 4
set find_cmd "find $HOME -maxdepth 4 -type d -not -path \"*/\\.*\""
for path in $excluded_paths
    # If the path is node_modules, ignore all node_modules folders recursively
    if test $path = "node_modules"
        set find_cmd "$find_cmd -not -path \"*/node_modules\" -not -path \"*/node_modules/*\""
    else
        set find_cmd "$find_cmd -not -path \"$path/*\""
    end
end

# Use skim (sk) for fuzzy directory selection with native Vim keybindings.
set selected_dir (eval $find_cmd | sk \
    --bind 'ctrl-d:half-page-down,ctrl-u:half-page-up' \
    --preview 'ls -la {}' \
    --height 80% \
    --layout=reverse \
    --border)

# Exit if no directory was selected
if test -z "$selected_dir"
    printf "%s[INFO]%s No directory selected. Exiting.\n" $color_info $color_reset
    exit 0
end

# Get the directory name for the session name
set session_name (basename "$selected_dir" | string replace -ar '[^a-zA-Z0-9]' '_')

# Display status message
printf "%s[INFO]%s Creating tmux session '%s' in '%s'...\n" $color_info $color_reset $session_name $selected_dir

# Check if a tmux session with this name already exists
tmux has-session -t "$session_name" 2>/dev/null

if test $status -ne 0
    # Create a new tmux session (detached) with the first window running nvim
    tmux new-session -d -s $session_name -c $selected_dir -n "nvim"
    tmux send-keys -t $session_name:1 "nvim ." C-m

    # Create a second window running a terminal (default shell)
    tmux new-window -t $session_name:2 -c $selected_dir -n "main term"

    # Create a third window running a terminal (default shell)
    tmux new-window -t $session_name:3 -c $selected_dir -n "long running term"

    # Create a fourth window running htop
    tmux new-window -t $session_name:4 -c $selected_dir -n "htop"
    tmux send-keys -t $session_name:4 "htop" C-m

    # Select the first window (nvim) as the active window
    tmux select-window -t $session_name:0

    printf "%s[SUCCESS]%s Tmux session '%s' created!\n" $color_success $color_reset $session_name
else
    printf "%s[INFO]%s Session '%s' already exists.\n" $color_info $color_reset $session_name
end

# Attach to the session
tmux attach-session -t "$session_name"
