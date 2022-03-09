#!/usr/bin/sh

echo "
P_IP='127.0.0.1'
P_PORT='7891'
SK_PORT='7891'
#export HTTP_PROXY=socks5://\$P_IP:\$P_PORT/ HTTPS_PROXY=socks5://\$P_IP:\$P_PORT/

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export INPUT_METHOD=ibus
export SDL_IM_MODULE=ibus

" >> $HOME/.zprofile
