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
P_URL=http://$P_IP:$P_PORT/
#export HTTP_PROXY=$P_URL export HTTPS_PROXY=$P_URL
alias jp="export HTTP_PROXY=$P_URL export HTTPS_PROXY=$P_URL"
' >> $init
