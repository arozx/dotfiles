function ssh --description 'Use Mosh for opted-in interactive SSH hosts'
    # Mosh is a terminal only; SSH options, remote commands and port forwards
    # must retain normal SSH behavior
    if test (count $argv) -ne 1; or string match -q -- '-*' $argv[1]
        command ssh $argv
        return $status
    end

    set -l host (string replace -r '^.*@' '' -- $argv[1])
    set -l hosts_file ~/.config/fish/mosh-hosts
    if not command -sq mosh; or not test -r $hosts_file
        command ssh $argv
        return $status
    end

    # The list contains exact SSH host aliases, one per line. Ignore comments.
    set -l hosts (string match -rv '^\s*(#|$)' < $hosts_file | string trim)
    if contains -- $host $hosts
        command mosh $argv[1]
    else
        command ssh $argv
    end
end
