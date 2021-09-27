export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="robbyrussell"
#ZSH_THEME="re5et"
ZSH_THEME="ys"


# CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"


plugins=( git extract sudo )

source $ZSH/oh-my-zsh.sh

################################
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

P_IP="127.0.0.1"
P_PORT="7891"
SK_PORT="7890"

alias jp="export http_proxy=http://${P_IP}:${P_PORT}/ && export https_proxy=http://${P_IP}:${P_PORT}/"
alias gpx="git config --global http.proxy 'socks5://${P_IP}:${SK_PORT}/' && git config --global https.proxy 'socks5://${P_IP}:${SK_PORT}/'"
alias ugpx="git config --global --unset http.proxy && git config --global --unset https.proxy"

source $HOME/.zprofile
