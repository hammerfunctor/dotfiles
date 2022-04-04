#!/usr/bin/env bash

# configure julia precompile cache per machine
depotpath="$1"

multijulia() {
  # uuid of root partition doesn't suit our use case here
  #local uuid="$(blkid `blkid -L root` -o value | sed '2q;d')"
  local uuid="$(lscpu | sed -nr '/Model name/ s/  / /g; s/.*:\s*(.*) @ .*/\1/p')"
  local realcache="$depotpath/multiverse/$uuid"
  local juliacache="$depotpath/compiled"
  [[ -d $realcache ]] || mkdir -p $realcache
  if [[ -d $juliacache ]]; then
    if [[ -L $juliacache ]]; then
      rm $juliacache
    else
      rm -rf $juliacache
    fi
  fi
  ln -s $realcache $juliacache
}

multijulia
