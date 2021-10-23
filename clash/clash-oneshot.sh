#!/bin/bash

cfgfname="$HOME/.config/clash/config.yaml"
srcfname="ghelper-clash.txt"

if [ -f $srcfname ]; then
    echo "$srcfname not fount"
    exit 1
fi
curl $(cat $srcfname) -o $cfgfname

sed -i 's/^external-contr.*$/external-controller: 127\.0\.0\.1:9090/' $cfgfname
sed -i 's/^port: .*$/port: 7891/' $cfgfname
sed -i 's/^socks-port: .*$/socks-port: 7890/' $cfgfname
sed -i 's/^log-level: .*$/log-level: silent/' $cfgfname
