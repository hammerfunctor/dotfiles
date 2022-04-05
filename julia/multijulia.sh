#!/usr/bin/env bash

# configure julia precompile cache per machine
depotpath="${1:-$HOME/.julia}"

multijulia() {
  # uuid of root partition doesn't suit our use case here
  #local uuid="$(blkid `blkid -L root` -o value | sed '2q;d')"

  # model name of amd cpu seems not to include a `@'
  #local uuid="$(lscpu | sed -nr '/Model name/ s/  / /g; s/.*:\s*(.*) @ .*/\1/p')"

  local uuid="$(lscpu | grep name)"
  case $uuid in
    *with*)
      # e.g.: AMD Ryzen 5 5600U with Radeon Graphics
      uuid="$(echo $uuid | sed -nr 's/.*:\s*(.*) with .*/\1/p')";;
    *@*)
      # e.g.: Intel(R) Core(TM) i7-10700 CPU @ 2900 kHz
      uuid="$(echo $uuid | sed -nr 's/.*:\s*(.*) @ .*/\1/p')";;
    *)
      # do nothing
      ;;
  esac

  [[ -z "$uuid" ]] && echo "capture nothing as cpu name" && exit 1

  local realcache="$depotpath/multiverse/$uuid"
  local juliacache="$depotpath/compiled"
  [[ -d "$realcache" ]] || mkdir -p "$realcache"
  if [[ -d $juliacache ]]; then
    if [[ -L $juliacache ]]; then
      rm $juliacache
    else
      rm -rf $juliacache
    fi
  fi
  ln -s "$realcache" $juliacache
}

multijulia
