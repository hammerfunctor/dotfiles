#!/usr/bin/env bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

# modify aururl to Tsinghua mirror
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
