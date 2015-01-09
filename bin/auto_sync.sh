#! /bin/bash

TO_DIR="/home/david/Documents/code/projects/environment"

BIN_DIR="/home/david/.bin"
NGINX_HOME="/usr/local/share/nginx"

# copy script utility in ~/.bin directory
cp $BIN_DIR/*.sh $TO_DIR/bin
cp $BIN_DIR/*.py $TO_DIR/bin
cp $BIN_DIR/goto $TO_DIR/bin

# Nginx
cp $NGINX_HOME/conf/nginx.conf $TO_DIR/config
cp /etc/init.d/nginx $TO_DIR/etc/init.d

