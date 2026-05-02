function gw-tmuxinator --description "Open worktree in a tmuxinator session"
    set -l wt $argv[1]
    set -l session (basename $wt)
    set -l template "worktree"
    set -q GW_TMUXINATOR_TEMPLATE; and set template $GW_TMUXINATOR_TEMPLATE

    if tmux has-session -t $session 2>/dev/null
        tmux attach -t $session
    else
        tmuxinator start $template $session $wt
    end
end
