#! /bin/bash
#
####################################
#
# Script Name:
#
#    configuration.sh
#
# Purpose:
#
#    配置文件相关的函数
#
####################################

##
# 读配置文件中的配置参数
#
# @file   配置文件
# @key    参数名
# @return 参数值
#
function load_config_key(){
   #echo "file: $1"
   #echo "key:  $2"
   section=$(echo $2 | cut -d '.' -f 1)
   key=$(echo $2 | cut -d '.' -f 2)
   sed -n "/\[$section\]/,/\[.*\]/{
      /^\[.*\]/d
      /^[ \t]*$/d
      /^$/d
      /^#.*$/d
      s/^[ \t]*$key[ \t]*=[ \t]*\(.*\)[ \t]*/\1/p
   }" $1
}

