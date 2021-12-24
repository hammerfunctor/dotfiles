#!/bin/bash

cfgfname="$HOME/.config/clash/config.yaml"
srcfname="$(dirname $0)/ghelper-clash.txt"

[ ! -d $(dirname $cfgfname) ] && mkdir -p $(dirname $cfgfname)
[ ! -f $srcfname ] && echo "$srcfname not found." && exit 1

curl $(cat $srcfname) -o $cfgfname

sed -i 's/^external-contr.*$/external-controller: 127\.0\.0\.1:9090/' $cfgfname
sed -i 's/^port: .*$/port: 7891/' $cfgfname
sed -i 's/^socks-port: .*$/socks-port: 7891/' $cfgfname
sed -i 's/^mixed-port: .*$/mixed-port: 7891/' $cfgfname
sed -i 's/^log-level: .*$/log-level: silent/' $cfgfname
