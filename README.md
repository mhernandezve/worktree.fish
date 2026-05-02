# worktree.fish

A port of [DHH's agent-git-trees.sh](https://gist.github.com/dhh/18575558fc5ee10f15b6cd3e108ed844) as Plugin for *fish shell*

## Install

With [fisherman]

```fish
$ fisher install timnew/worktree.fish
```

## Usage

### Create a new worktree and branch

```fish
$ gwa <branch name>
```

### Remove the current worktree and its associated branch

```fish
$ gwd
```

### List all worktrees

```fish
$ gwl
```

### Navigate to a worktree or back to base directory

```fish
$ gwcd <branch name>
```

return to base directory

```fish
$ gwcd
```

### Select and open a worktree

```fish
$ gw
```

Interactively select a worktree and open it. If there is only one worktree, it is selected automatically. If there are multiple worktrees, `fzf` is used with a `git status` preview.

You can customize how the worktree is opened:

- Via environment variable:
  ```fish
  set -x GW_OPENER tmux
  gw
  ```

- Via `--with` flag (overrides the variable):
  ```fish
  gw --with code
  gw --with nvim
  ```

If neither is set, `gw` defaults to `cd` into the worktree.

Requires `fzf` installed (only needed when there are multiple worktrees).

#### Wrappers for complex openers

If your opener needs extra arguments, create a wrapper function:

```fish
function gw-tmux
    set -l wt $argv[1]
    set -l repo (basename $wt)
    tmux new-session -c $wt -s $repo
end
```

Then use it with:

```fish
set -x GW_OPENER gw-tmux
```

#### Tmuxinator wrapper

The `wrappers/gw-tmuxinator.fish` example opens worktrees in a tmuxinator session. It uses the `worktree-ai` template by default, which you can override via the `GW_TMUXINATOR_TEMPLATE` environment variable:

```fish
set -x GW_OPENER gw-tmuxinator
set -x GW_TMUXINATOR_TEMPLATE my-custom-template
```

Hope you have a _fast_ swim!

[fisherman]: https://github.com/fisherman/fisherman