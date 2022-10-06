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
