#!/bin/sh

dir=$(dirname $(readlink -f $0))

ln -s $dir/init-preload-local.el $HOME/.emacs.d/lisp/init-preload-local.el
ln -s $dir/init-local.el $HOME/.emacs.d/lisp/init-local.el
