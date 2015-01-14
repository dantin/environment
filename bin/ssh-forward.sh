#! /bin/bash

# 加载公共函数脚本
source /home/david/.bin/config.sh

CONFIG="/home/david/Documents/work/fangdd/forward.config"
SCRIPT_NAME=`basename $0`


cd /home/david/Temp/socket

# 开SSH隧道
#
# 参数：
# socket      本地socket句柄
# local port  本地映射端口
# username    跳板机用户名
# jump host   跳板机主机名
# jump port   跳板机端口
# remote host 远程主机名
# remote port 远程主机地址
#
open_tunnel(){
    socket=$1
    local_port=$2
    username=$3
    jump_host=$4
    jump_port=$5
    remote_host=$6
    remote_port=$7

    ssh -M -S $socket -p$jump_port -N -f -L $local_port:$remote_host:$remote_port $username@$jump_host
}

# 监测隧道状态
#
# 参数：
# socket      本地socket句柄
# username    跳板机用户名
# jump host   跳板机主机名
#
check_tunnel(){
    socket=$1
    username=$2
    jump_host=$3
    ssh -S $socket -O check $username@$jump_host
}

# 关闭隧道
#
# 参数：
# socket      本地socket句柄
# username    跳板机用户名
# jump host   跳板机主机名
#
close_tunnel(){
    socket=$1
    username=$2
    jump_host=$3
    ssh -S $socket -O exit $username@$jump_host
}

# 获取节点名称
#
get_node(){
    if [ -z $1 ]; then
        echo "empty node name"
        exit 1
    else
        case $1 in
            s1)
                echo "s1"
                ;;
            s2)
                echo "s2"
                ;;
            db)
                echo "db"
                ;;
            *)
                echo "error node name"
                exit 1
                ;;
        esac
    fi
}

# Main函数
#
SCRIPT_NAME=`basename $0`

case $1 in
    open)
        echo "Open tunnel to $2"
        node=$(get_node "$2")
        
        socket=$(load_config_key $CONFIG "$node.socket")
        local_port=$(load_config_key $CONFIG "$node.local_port")
        username=$(load_config_key $CONFIG "fdd.username")
        jump_host=$(load_config_key $CONFIG "fdd.host")
        jump_port=$(load_config_key $CONFIG "fdd.port")
        remote_host=$6$(load_config_key $CONFIG "$node.remote_host")
        remote_port=$7$(load_config_key $CONFIG "$node.remote_port")

        open_tunnel $socket $local_port $username $jump_host $jump_port $remote_host $remote_port
        ;;
    check)
        echo "Check tunnel to $2"
        node=$(get_node "$2")

        socket=$(load_config_key $CONFIG "$node.socket")
        username=$(load_config_key $CONFIG "fdd.username")
        jump_host=$(load_config_key $CONFIG "fdd.host")
        check_tunnel $socket $username $jump_host
        ;;
    close)
        echo "Close tunnel to $2"
        node=$(get_node "$2")

        socket=$(load_config_key $CONFIG "$node.socket")
        username=$(load_config_key $CONFIG "fdd.username")
        jump_host=$(load_config_key $CONFIG "fdd.host")
        close_tunnel $socket $username $jump_host
        ;;
    *)
        echo
        echo "Usage: $SCRIPT_NAME {open|check|close} {s1|s2|db}"
        ;;
esac
