#!/bin/sh

export DEFAULT_REMOTE_NAME="origin"
export DEFAULT_PRIMARY_BRANCH_NAME="master"

### NODE

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

### PYTHON

python3_path="$HOME/Library/Python/3.9/bin"
poetry_path="$HOME/.poetry/bin"

PATH="${PATH}:${python3_path}"
PATH="${PATH}:${poetry_path}"

export PATH
