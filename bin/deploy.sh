#! /bin/bash

HOME="/home/david"
SRC="$HOME/Documents/code/projects/catalyst/public"
DST="/var/www/catalyst"

sudo rm -rf $DST/*
sudo cp -R $SRC/* $DST
