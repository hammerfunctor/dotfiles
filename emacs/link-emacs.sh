#!/bin/sh

dir=$(dirname $(readlink -f $0))

ln -sf $dir/init-preload-local.el $HOME/.emacs.d/lisp/init-preload-local.el
ln -sf $dir/init-local.el $HOME/.emacs.d/lisp/init-local.el
