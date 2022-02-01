#!/usr/bin/env bash

[ "$(lsb_release -i --short)" != "Arch" ] && exit 1

# pacman use Tsinghua mirror
sed -i \
  '1s:^:Server = https\://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch\n:' \
  /etc/pacman.d/mirrorlist

# customize `pacman.conf`
[ -z $(command -v perl) ] && pacman -S perl
perl -0777 -i \
  -pe 's/#Color/Color/;' \
  -pe 's/#ParallelDownloads/ParallelDownloads/;' \
  -pe 's/#\[multilib\]\n#/[multilib]\n/' \
  /etc/pacman.conf

# archlinuxcn from Tsinghua mirror
echo '
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
' >> /etc/pacman.conf
pacman -Sy archlinuxcn-keyring

