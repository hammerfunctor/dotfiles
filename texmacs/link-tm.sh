#!/bin/sh

basedir=$(dirname $(readlink -f $0))
TMHOME=$HOME/.TeXmacs

subs () {
    tmsubdir=$TMHOME/$1
    for file in $basedir/$1/*; do
        filebasename=$(basename $file)
        dstfile=$tmsubdir/$filebasename
        if [[ -f $dstfile && ! -h $dstfile ]]; then
            echo "$dstfile exists, skip it..."
        else
            ln -sf $file $dstfile
        fi
    done
}

for f in $basedir/*; do
    if [ -d $f ]; then
        subs $(basename $f)
    fi
done
