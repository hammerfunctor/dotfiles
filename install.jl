#!/usr/bin/env julia

# Please ensure that zsh, nvim and emacs is installed

using Pkg; Pkg.add("Lazy")
using Lazy

path = @__DIR__
home = ENV["HOME"]
shell = ENV["SHELL"]

function overwrite(orig::String, new::String)
    print("Overwrite $orig?(y/n)")
    p = readline()
    if p == "y" || p == "Y"
        # if the file exists, remove it
        if isfile("$orig")
            rm("$orig")
        end

        if isfile("$path/$new")
            @> `mkdir -p $(dirname(orig))` run()
            @> `ln -sf $path/$new $orig` run()
        else
            println("$path/$new not exist, skipping...")
        end
    end
end

function install(f::Function, name::String)
    print("Install $name?(y/n)")
    p = readline()
    if p == "y" || p == "Y"
        try
            f()
            println("$name DONE.")            
        catch e
            println(e)
        end
    else
        println("Skip $name.")
    end

    println()
end

function nvim()
    try
        run(`which nvim`)
    catch e
        println("nvim not in PATH, fix it in shell =>")
        @> `$shell` run()
    end
    
    if ! isfile("$home/.local/share/nvim/site/autoload/plug.vim")
        @> `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'` run()
    else
        println("vim-plug for nvim FOUND")
    end
    overwrite("$home/.config/nvim/init.vim", "init.vim")
end

function emacs() end

function ohmyzsh()
    try
        run(`which zsh`)
    catch e
        # zsh not in path
        println("zsh not in PATH, fix it in shell =>")
        @> `$shell` run()
    end

    if ! isdir("$home/.oh-my-zsh")
        # install oh-my-zsh
        println("Installing oh-my-zsh")
        @> `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh` pipeline(`sh`) run()
        overwrite("$home/.zshrc", "zshrc")
        @> `chsh -s /bin/zsh` run()
    else
        # no need to do anything
        println("oh-my-zsh FOUND.")
    end
end

function rbenv()
    if isdir("$home/.rbenv")
        println("rbenv FOUND.")
    else
        println("Installing rbenv")
        
        @> `git clone https://github.com/rbenv/rbenv.git $home/.rbenv` run()
        @> `echo 'export PATH=$HOME/.rbenv/bin:$PATH'` pipeline(stdout="$home/.zprofile", append=true) run()
        @> `echo 'eval "$(rbenv init -)"'` pipeline(stdout="$home/.zprofile", append=true) run()

        # ruby-build
        # TODO
        
    end
end

function pyenv() end

function homebrew() end

function rustup()
    try
        run(`which rustup`)
        println("rustup FOUND")
    catch e
        println("Installing rustup...")
        @> `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs` pipeline(`sh`) run()
    end
end

function alacritty()    
    overwrite("$home/.config/alacritty/alacritty.yml", "alacritty.yml")
end


module Tmp
export ohmyrepl
include("build-ohmyrepl.jl")
end #module

install(ohmyzsh, "oh-my-zsh")
install(rustup, "rustup")
install(nvim, "neovim")
install(ohmyrepl, "OhMyREPL")
