#!/usr/bin/bash

[ -z $(which julia) ] && echo "julia not found, cannot build OhMyREPL." && exit 0
julia -e 'using Pkg; Pkg.add(["PackageCompiler","OhMyREPL"])'
julia -e "
using PackageCompiler;
PackageCompiler.create_sysimage(
  :OhMyREPL;
  precompile_statements_file=\"$(dirname $0)/ohmyrepl_precompile.jl\",
  sysimage_path=\"$HOME/.julia/sys_ohmyrepl.so\")"
