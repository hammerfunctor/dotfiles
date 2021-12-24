#!/bin/sh

[ -d $HOME/.rbenv ] && echo "rbenv found." && exit 0

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

pushd ~/.rbenv && src/configure && make -C src
echo '
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"' >> ~/.zprofile
exec "$SHELL"
~/.rbenv/bin/rbenv init
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# ruby-build
mkdir -p "$(~/.rbenv/bin/rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build
 
popd
