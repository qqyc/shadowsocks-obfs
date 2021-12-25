#!/bin/sh


# init
PASSWORD=${PASSWORD:-"obfspasswd"}
METHOD=${METHOD:-"chacha20-ietf-poly1305"}
PORT=${PORT:-8888}
OBFS_TYPE=${OBFS_TYPE:-"http"}


# print configs
echo "password: $PASSWORD"
echo "method: $METHOD"
echo "port: $PORT"
echo "obfs type: $OBFS_TYPE"


# modify config files
sed -i "s/obfspasswd/$PASSWORD/g" /etc/shadowsocks-libev/config.json
sed -i "s/http/$OBFS_TYPE/g" /etc/shadowsocks-libev/config.json
sed -i "s/chacha20-ietf-poly1305/$METHOD/g" /etc/shadowsocks-libev/config.json
sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf
rm /etc/nginx/sites-enabled/default


# print configs
cat /etc/shadowsocks-libev/config.json
cat /etc/nginx/conf.d/default.conf


# start nginx
nginx


# start obfs server
ss-server -c /etc/shadowsocks-libev/config.json
