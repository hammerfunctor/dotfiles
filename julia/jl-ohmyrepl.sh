#!/usr/bin/bash

sysimage="${1:-$HOME/.julia/compiled/sys_ohmyrepl.so}"

[[ -z $(command -v julia) ]] && echo "julia not found, cannot build OhMyREPL." && exit 0
julia -e 'using Pkg; Pkg.add(["PackageCompiler","OhMyREPL"])'
julia -e "
using PackageCompiler;
PackageCompiler.create_sysimage(
  :OhMyREPL;
  precompile_statements_file=\"$(dirname $0)/ohmyrepl_precompile.jl\",
  sysimage_path=\"$sysimage\")"
