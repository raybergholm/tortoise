# Overview

This is a quick template for bundling shell config files together if you dislike dumping everything into one file. This contains some commonly configured env vars and helper functions ready to use out of the box.

This was put together for a Mac running [Oh My Zsh](https://ohmyz.sh/) but this should work for any similar setup.

## Quickstart

Copy the content of [the root config file](`./root_config.sh`) to your `.bash_profile` or `.zshrc` file, change the path to where this repo will be located.

Add additional environmental vars, aliases, shell functions, files, etc as required.

The [bash-autocomplete.sh](./shell_configs/bash-autocomplete.sh) script depends on [bash-completion](https://github.com/scop/bash-completion)
