#!/bin/sh

dir=$(dirname $(readlink -f $0))
configdir=$HOME/.emacs.d/lisp

subs () {
    if [[ -f $configdir/$1 && ! -h $configdir/$1 ]]; then
        echo "$configdir/$1 exists, skip it..."
    else
        ln -sf $dir/$1 $configdir/$1
    fi
}
subs init-preload-local.el 
subs init-local.el

#ln -sf $dir/init-preload-local.el $HOME/.emacs.d/lisp/init-preload-local.el
#ln -sf $dir/init-local.el $HOME/.emacs.d/lisp/init-local.el
