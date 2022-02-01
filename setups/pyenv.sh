#!/usr/bin/env bash

[ -d $HOME/.pyenv ] && echo "pyenv found." && exit 0

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src
echo '
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"' >> ~/.zprofile
exec "$SHELL"
~/.pyenv/bin/pyenv init
