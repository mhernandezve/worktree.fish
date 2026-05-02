function gw --description "Select and open a git worktree"
    argparse --name=gw 'with=' -- $argv
    or return

    set -l opener ""
    if set -q _flag_with
        set opener $_flag_with
    end

    # Resolve opener: --with > GW_OPENER > cd
    if test -z "$opener"
        set -q GW_OPENER; and set opener $GW_OPENER
    end
    test -z "$opener"; and set opener "cd"

    # Validate git repo
    git rev-parse --show-toplevel >/dev/null 2>&1; or begin
        echo "gw: not inside a git repository"
        return 1
    end

    set -l lines (git worktree list 2>/dev/null)
    test (count $lines) -gt 0; or return

    set -l line ""
    if test (count $lines) -eq 1
        set line $lines[1]
    else
        if not type -q fzf
            echo "gw: fzf is required when there are multiple worktrees"
            return 1
        end
        set line (printf "%s\n" $lines | fzf --prompt="worktrees> " \
            --preview='p=$(printf "%s" {} | cut -d" " -f1); git -C "$p" status -sb 2>/dev/null')
    end

    test -n "$line"; or return

    set -l wt (string split -f1 " " -- $line)

    if test "$opener" = "cd"
        cd $wt
    else
        $opener $wt
    end
end
