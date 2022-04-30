#!/usr/bin/zsh

# install all systemd items in this directory as user

target="$HOME/.config/systemd/user"
[[ ! -d $target ]] && mkdir -p $target

parentdir="$(dirname $(realpath $0))"
for i in $parentdir/**/systemd/*; do
  echo "ln -sf $i $target"
  ln -sf $i $target
done
