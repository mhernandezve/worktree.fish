function gw-tmuxinator --description "Open worktree in a tmuxinator session"
    set -l wt $argv[1]
    set -l session (basename $wt)

    if tmux has-session -t $session 2>/dev/null
        tmux attach -t $session
    else
        tmuxinator start worktree-ai $session $wt
    end
end
