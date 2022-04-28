#!/bin/sh

# This for environments that still have Python2 preinstalled by default.
# Nowadays there's almost no reason to use Python2, but Python2 being default sometimes does funky things, 
# so let's just always alias python and pip to their Python3 equivalents.
alias python="python3"
alias pip="pip3"
