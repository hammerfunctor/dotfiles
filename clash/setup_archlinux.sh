#!/usr/bin/env bash

sudo pacman -S --needed clash yacd darkhttpd
[[ "$USER" = "root" ]] && echo "Run this script as non-root user" && exit 1

sudo ln -sf $(realpath $(dirname $0))/yacd.service /usr/lib/systemd/user/yacd.service
systemctl --user enable clash --now
systemctl --user enable yacd --now
