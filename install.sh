#!/usr/bin/env bash

# Check: oh-my-zsh rbenv pyenv homebrew(Darwin) rustup julia-OhMyREPL

install () {
    echo -n "Installing $1?(y/n)"
    read input
    if [ "$input" == "y" -o "$input" == "Y" ]; then
        return 1
    else
        return 0
    fi
}

overwrite () {
    echo -n "Overwrite $1?(y/n)"
    read input
    if [ "$input" == "y" -o "$input" == "Y" ]; then
        rm ~/$1
        ln -f $(pwd)/$1 ~/$1
    fi
}

# vim
overwrite ".vimrc"

# oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    overwrite ".zshrc"
    chsh -s /bin/zsh
    zsh
else
    echo "oh-my-zsh found."
fi


# rbenv
if [ ! -d ~/.rbenv ]; then
    install "rbenv"
    if [ 1 == $? ]; then

        echo "rbenv installing..."

        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        cd ~/.rbenv && src/configure && make -C src
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zprofile
        echo 'eval "$(rbenv init -)"' >> ~/.zprofile
        exec "$SHELL"
        ~/.rbenv/bin/rbenv init
        # curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

        # ruby-build
        mkdir -p "$(~/.rbenv/bin/rbenv root)"/plugins
        git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build
    else
        echo "rbenv installation cancelled."
    fi
else
    echo "rbenv found."
fi


# pyenv
if [ ! -d ~/.pyenv ]; then
    install "pyenv"
    if [ 1 == $? ]; then

        echo "pyenv installing..."

        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        cd ~/.pyenv && src/configure && make -C src
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
        echo 'eval "$(pyenv init -)"' >> ~/.zprofile
        exec "$SHELL"
        ~/.pyenv/bin/pyenv init
    else
        echo "pyenv installation cancelled."
    fi
else
    echo "pyenv found."
fi


# homebrew
if [ "$(uname)" == "Darwin" -a ! -f /usr/local/bin/brew ]; then
    install "homebrew"
    if [ 1 == $? ]; then
        echo "homebrew installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
        echo "homebrew installation cancelled."
    fi
else
    echo "No need to install homebrew."
fi


# rustup
if [ "$(which rustup)" == "" ]; then
    install "rustup"
    if [ 1 == $? ]; then
        echo "rustup installing..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    else
        echo "rustup installation cancelled."
    fi
else
    echo "rustup found."
fi



# julia OhMyREPL
if [ ! -f $HOME/.julia/sys_ohmyrepl.so ]; then

    # if julia is not installed
    #install "julia"
    #if [ 1 == $? ]; then
    #    echo -n "url="
    #    read url
    #    wget --directory-prefix=$HOME $url
    #    tar xvzf $HOME/${url##/*/} 

    install "julia - OhMyREPL"
    if [ 1 == $? ]; then
        echo 
        echo "sys_ohmyrepl.so compiling..."
        JULIA_PKG_SERVER="cn-east.pkg.juliacn.com" julia -e 'using Pkg; Pkg.add("PackageCompiler"); Pkg.add("OhMyREPL")'
        julia -e "using PackageCompiler; PackageCompiler.create_sysimage(:OhMyREPL; precompile_statements_file=\"$(pwd)/ohmyrepl_precompile.jl\", sysimage_path=\"$HOME/.julia/sys_ohmyrepl.so\")"
        echo 'alias j="JULIA_PKG_SERVER=\\"cn-east.pkg.juliacn.com\\" julia --sysimage $HOME/.julia/sys_ohmyrepl.so"' >> ~/.zprofile
    else
        echo "julia - OhMyREPL installation cancelled."
    fi
else
    echo "OhMyREPL compiled."
fi
