#!/usr/bin/bash

# When update a major version, migrate the installed packages
oldversion="$(ls $HOME/.julia/environments/ | sort | tail -n 2 | head -n 1)"
echo -n "Migrate from $oldversion? (y/N)"; read
if [[ "$REPLY" != "y" ]]; then
  echo -n "Enter the version you want to migrate from: "; read
  oldversion="$REPLY"
fi

echo "# remove packages you don't want to keep, then exit" > /tmp/jl-to_install
cut -d ' ' -f 1 < "$HOME/.julia/environments/$oldversion/Project.toml" | tail -n +2 >> /tmp/jl-to_install
vim /tmp/jl-to_install

/usr/bin/julia -e "\
pkgs = filter(x->!startswith(x,'#') && !isempty(strip(x)),\
  strip.(split(ARGS[1],'\n')));\
using Pkg; Pkg.add(pkgs)" "$(cat /tmp/jl-to_install)"
