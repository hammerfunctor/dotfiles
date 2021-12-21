#!/usr/bin/julia

using Pkg; Pkg.add(["PackageCompiler","OhMyREPL"])#, "Lazy"])
using PackageCompiler#, OhMyREPL
#using Lazy

path = @__DIR__
home = ENV["HOME"]

function ohmyrepl()
    PackageCompiler.create_sysimage(:OhMyREPL; precompile_statements_file="$path/ohmyrepl_precompile.jl", sysimage_path="$home/.julia/sys_ohmyrepl.so")
    #@> `echo 'alias j="julia --sysimage $HOME/.julia/sys_ohmyrepl.so"'` pipeline(stdout="$home/.zprofile",append=true) run()
end

if Main == @__MODULE__
    ohmyrepl()
end
