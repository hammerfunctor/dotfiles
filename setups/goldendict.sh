#!/usr/bin/env bash

# 2022-03-18, this package comes from archlinuxcn
pkg="goldendict-qt5-git"
echo "Installing $pkg from: [archlinuxcn]"
sudo pacman -S --needed $pkg

golddir=$(readlink -m "${2:-$HOME/dev/sw/goldendict}")
echo "Place the repository at $golddir"

case $1 in
  git)
    URL="git@github.com:hammerfunctor/goldendict.git"
    ;;
  https)
    URL="https://github.com/hammerfunctor/goldendict.git"
    ;;
  *)
    echo "usage: $0 (git|https) [ /path/to/goldendict ], to clone using git protocol or https protocol"
    exit 1
    ;;
esac

git clone $URL $golddir
[[ -L $HOME/.goldendict ]] && rm $HOME/.goldendict
ln -sf $golddir/config $HOME/.goldendict
sudo ln -sf $golddir/dictdd /usr/local/share
cp $golddir/goldendict.desktop ~/.config/autostart
