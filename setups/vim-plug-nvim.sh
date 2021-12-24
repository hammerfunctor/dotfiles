#!/bin/sh

[ -d $HOME/.local/share/nvim/site/autoload/plug.vim ] && echo "vim-plug for neovim found." && exit 0
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
