#!/bin/bash

cfgfname="$HOME/.config/clash/config.yaml"
srcfname="$(dirname $0)/ghelper-clash.txt"

[ ! -d $(dirname $cfgfname) ] && mkdir -p $(dirname $cfgfname)
[ ! -f $srcfname ] && echo "$srcfname not found." && exit 1

curl $(cat $srcfname) -o $cfgfname

sed -i \
  -e 's/^external-contr.*$/external-controller: 127\.0\.0\.1:9090/' \
  -e 's/^port: .*$/port: 7891/' \
  -e 's/^socks-port: .*$/socks-port: 7891/' \
  -e 's/^mixed-port: .*$/mixed-port: 7891/' \
  -e 's/^log-level: .*$/log-level: silent/' \
  -e 's/^bind-address: .*$/bind-address: 0.0.0.0/' \
  $cfgfname


# sometimes we want to proxy all connections, especially for steam community
# so we create an extra config file to match all url with a first 'MATCH'
globalname=$(dirname $cfgfname)/config.global.yaml
sed \
  -e 's/^port: .*$/port: 7892/' \
  -e 's/^socks-port: .*$/socks-port: 7892/' \
  -e 's/^mixed-port: .*$/mixed-port: 7892/' \
  -e 's/type: select/type: url-test\n  url: http:\/\/www\.gstatic\.com\/generate_204\n  interval: 600/' \
  -e 's/rules:.*/rules:\n- MATCH,Ghelper/' \
  $cfgfname > $globalname
