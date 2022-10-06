#!/bin/sh

# Prune selected tag and push to remote.
# Optional first arg lets you override the remote name, defaults to $DEFAULT_REMOTE_NAME as defined in env_vars.sh
git-prune-tag()
{
  if [ $# -lt 1 ] || [ -z "$1" ] ; then
    echo "Add the tag name!"
    exit 1
  fi

  remote_name=$DEFAULT_REMOTE_NAME
  if [ $# -gt 1 ] && [ -n "$2"] ; then
    remote_name="$2"
  fi

  tag_name="$1"
  git tag -d $tag_name
  git push $remote_name :refs/tags/$tag_name
}

# Clean up hanging branches (branches that track a remote branch which is now gone, usually because it's been merged & deleted).
# This requires manual confirmation to delete branches.
git-prune-branches()
{
  git fetch -p
  locals_with_remote_gone=$(git branch -vv | grep "gone" | awk '{print $1}')
  if [ ${#locals_with_remote_gone} = 0 ]; then
    echo "No hanging branches to prune, everything is clean!"
    return 0
  fi

  echo "These branches no longer have an upstream:\n"
  echo "$locals_with_remote_gone\n"

  read "confirmation?Enter \"yes\" to prune these branches: " 
  if [ $confirmation = "yes" ]; then
    local IFS=$'\n'
    # Required for ZSH iterate through a 'for line in line1\nline2\nline3' scenario
    if [ $ZSH_VERSION ]; then 
      setopt sh_word_split
    fi

    for branch_name in $locals_with_remote_gone
    do
      git branch -D $branch_name
    done
  fi
}

# Keeps your master/main/whatever branch up to date. Can also be used to prepare another branch to be rebased onto the primary branch
# This pulls the primary branch if it's behind. If it's ahead or diverged, this will alert the user to fix it manually.
# Optional first arg lets you override the primary branch name, defaults to $DEFAULT_PRIMARY_BRANCH_NAME as defined in env_vars.sh
git-sync()
{
  primary_branch=$DEFAULT_PRIMARY_BRANCH_NAME
  if [ $# -gt 0 ] && [ -n "$1" ] ; then
    primary_branch="$1"
  fi
  current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  
  if [ $current_branch != $primary_branch ]; then
    git checkout $primary_branch
  fi
  git fetch -p
  
  local=$(git rev-parse @)
  remote=$(git rev-parse "@{u}")
  base=$(git merge-base @ "@{u}")
  if [ $local = $remote ]; then
      # up to date, can just do nothing
  elif [ $local = $base ]; then
      git pull
  elif [ $remote = $base ]; then
      echo "Local ${primary_branch} is ahead, this is beyond this script's paygrade so fix it manually"
  else
      echo "Local and remote ${primary_branch} have diverged, this is beyond this script's paygrade so fix it manually"
  fi

  if [ $current_branch != $primary_branch ]; then
    git checkout $current_branch
  fi
}

# Compares local & remote branches and echos if the local is up to date/ahead/behind/diverged
git-check-diverged()
{
  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")

  git fetch -p

  if [ $LOCAL = $REMOTE ]; then
      echo "Up-to-date"
  elif [ $LOCAL = $BASE ]; then
      echo "Need to pull"
  elif [ $REMOTE = $BASE ]; then
      echo "Need to push"
  else
      echo "Diverged"
  fi
}
