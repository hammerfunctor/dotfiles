#!/usr/bin/env bash

[ "$(lsb_release -i --short)" != "Ubuntu" ] && exit 1

RELEASE_NAME="$(lsb_release -c --short)"
echo "
# source code mirrors are commented in order to speed up, uncomment them if needed
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-security main restricted universe multiverse

# rc-source, not recommended
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $RELEASE_NAME-proposed main restricted universe multiverse
" > /etc/apt/sources.list
