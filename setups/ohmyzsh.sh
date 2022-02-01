#!/usr/bin/env bash

[ -d $HOME/.oh-my-zsh ] && echo "oh-my-zsh found." && exit 0
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
