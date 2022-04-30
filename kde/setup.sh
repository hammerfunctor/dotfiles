#!/usr/bin/env bash

dir="$(dirname $0)"

balooctl disable

cp "$dir/user-dirs.dirs" "~/.config/user-dirs.dirs"
cp "$dir/user-dirs.locale" "~/.config/user-dirs.locale"
