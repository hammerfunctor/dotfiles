P_IP='127.0.0.1'
P_PORT='7891'
SK_PORT='7891'
#GLOBAL_PORT='7892'

P_URL="http://$P_IP:$P_PORT/"
SK_URL="socks5://$P_IP:$SK_PORT/"
P_GLOBAL_URL="http://$P_IP:$GLOBAL_PORT/"

px() {
    if [ -z "$HTTP_PROXY" ]; then
        export HTTP_PROXY=$P_URL HTTPS_PROXY=$P_URL
        echo "Proxy set"
    else
        export HTTP_PROXY='' HTTPS_PROXY=''
        echo "Proxy unset"
    fi
}

alias gpx="git config --global http.proxy '$SK_URL' && git config --global https.proxy '$SK_URL'"
alias ugpx="git config --global --unset http.proxy && git config --global --unset https.proxy"
