#!/usr/bin/env bash

case $SHELL in
  *bash)
    init=$HOME/.bashrc
    ;;
  *zsh)
    init=$HOME/.zshrc
    ;;
esac

echo '
P_IP=$(echo $SSH_CLIENT | cut -d' ' -f 1)
P_PORT=7891
export http_proxy=http://$P_IP:$P_PORT/
export https_proxy=http://$P_IP:$P_PORT/' >> $init
