#!/bin/bash

sudo pacman -S --needed ibus-rime librime librime-data \
  noto-fonts-emoji unicode-emoji adobe-source-han-{sans,serif}-cn-fonts

rimedir=$(readlink -m "${2:-$HOME/dev/sw/ibus-rime}")
plumdir="$HOME/dev/co/plum"
echo "Place 'ibus-rime' at $rimedir, 'plum' at $plumdir"

case $1 in
  git)
    URL="git@github.com:hammerfunctor/ibus-rime.git"
    ;;
  https)
    URL="https://github.com/hammerfunctor/ibus-rime.git"
    ;;
  *)
    echo "usage: $0 (git|https) [ /path/to/ibus-rime ], to clone using git protocol or https protocol"
    exit 1
    ;;
esac

git clone $URL $rimedir
[[ -L $HOME/.config/ibus/rime ]] && rm $HOME/.config/ibus/rime
[[ -d $HOME/.config/ibus/rime ]] && echo "backup $HOME/.config/ibus/rime, or delete it." && exit 1
ln -sf $rimedir/rime $HOME/.config/ibus/rime
cp $rimedir/ibus-daemon.desktop ~/.config/autostart

# TODO: install plum

