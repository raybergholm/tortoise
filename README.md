# Overview

This is a quick template for bundling shell config files together if you dislike dumping everything into one file. This contains some commonly configured env vars and helper functions ready to use out of the box.

This was put together for a Mac running [Oh My Zsh](https://ohmyz.sh/) but this should work for any similar setup.

## Quickstart

Copy the content of [the root config file](`./root_config.sh`) to your `.bash_profile` or `.zshrc` file, change the path to where this repo will be located.

Add additional environmental vars, aliases, shell functions, files, etc as required.

The [bash-autocomplete.sh](./shell_configs/bash-autocomplete.sh) script depends on [bash-completion](https://github.com/scop/bash-completion)

## Setting up the local repository to be a one-way pull-only repo

Most likely this is getting used in scenarios where this repo is a starting point, but then there will be more stuff being added which includes things which really do not belong in a public repo. If so, here's a few ideas to prevent accidents. It's also a good idea to make your changes in a branch that's different from `master`.

### Remove the remote push URL

After cloning this repo, remove the remote push URL with the following command:

`git remote set-url origin --push ""`

Attempting to push will fail since the local repo no longer has a reference to the remote when attempting to push.

This method still lets you pull from remote using a normal `git pull` command.

### Completely remove the remote URL

After cloning this repo, you can always straight up remove the remote URL with the following command:

`git remote remove origin`

This completely severs the connection to the upstream remote repo which safeguards from any accidental pulls/pushes. If you need to update from remote, use the following command:

`git pull git@github.com:raybergholm/tortoise.git`
