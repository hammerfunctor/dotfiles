#!/bin/sh

[ "$(uname)" =~ "Darwin" ] && echo "Not a Mac, not to install homebrew" && exit 0
[ ! -z $(command -v brew) ] && echo "homebrew already installed." && echo 0
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
