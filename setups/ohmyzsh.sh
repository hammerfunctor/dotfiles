#!/bin/sh

[ -d $HOME/.oh-my-zsh ] && echo "oh-my-zsh found." && exit 0
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
