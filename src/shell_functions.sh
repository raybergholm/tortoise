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

# Keeps your master/main/whatever branch up to date. Can be used to prepare a branch to be rebased
# Optional first arg lets you override the primary branch name, defaults to $DEFAULT_PRIMARY_BRANCH_NAME as defined in env_vars.sh
git-sync()
{
  primary_branch=$DEFAULT_PRIMARY_BRANCH_NAME
  if [ $# -gt 0 ] && [ -n "$1" ] ; then
    primary_branch="$1"
  fi
  current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

  git checkout $primary_branch
  git fetch -p
  git pull
  git checkout $current_branch
}
