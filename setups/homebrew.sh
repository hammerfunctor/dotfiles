#!/bin/sh

[ "$(uname)" =~ "Darwin" ] && echo "Not a Mac, not to install homebrew" && exit 0
[ ! -z $(command -v brew) ] && echo "homebrew already installed." && echo 0
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
