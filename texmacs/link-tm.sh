#!/bin/sh

basedir=$(dirname $(readlink -f $0))
progsdir=$basedir/progs
tmprogs=$HOME/.TeXmacs/progs

for file in $progsdir/*.scm; do
    filebasename=$(basename $file)
    if [[ -f $tmprogs/$filebasename && ! -h $tmprogs/$filebasename ]]; then
        echo "$tmprogs/$filebasename exists, skip it..."
    else
        ln -sf $file $tmprogs/$filebasename
    fi
done
