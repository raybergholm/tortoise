# Tortoise docs

## Built-in functions

### git-check-diverged

```bash
reload-me
```

### git-prune-branches

```bash
git-prune-branches
```

Clean up hanging branches (branches that track a remote branch which is now gone, usually because it's been merged & deleted). This checks your local branches that have an upstream remote branch; if the remote is gone, then it is earmarked for pruning. The branches which will be pruned are displayed and manual confirmation is required to go through with the pruning.

### git-prune-tags

```bash
git-prune-tags tagname
```

### git-sync

```bash
git-sync
```

Swaps to the trunk branch (by default `$DEFAULT_PRIMARY_BRANCH_NAME`), pulls from remote then swap back to your current branch.

### show-path

```bash
show-path
```

Show the $PATH var formatted as a list. Since $PATH often ends up becoming a long string that looks like `/somewhere:/somewhere/else:/somewhere/long/deep/path/to/some/dir` repeated over and over, this function can be used to check what's in the $PATH when troubleshooting issues.

### reload-me

```bash
reload-me
```

Does the same thing as `source $HOME/.zshrc` with less typing required.
