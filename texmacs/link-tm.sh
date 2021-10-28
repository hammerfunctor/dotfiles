#!/bin/sh

dir=$(dirname $(readlink -f $0))

ln -sf $dir/progs/my-init-buffer.scm $HOME/.TeXmacs/progs/my-init-buffer.scm
ln -sf $dir/progs/my-init-texmacs.scm $HOME/.TeXmacs/progs/my-init-texmacs.scm
