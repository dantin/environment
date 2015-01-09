#!/bin/bash

# 加载公共函数脚本
source /home/david/.bin/config.sh

# 自动登录函数
#
# 参数：
# password 密码
# host     远程机器，格式'user@host'
#
auto_login_ssh(){
    # StrictHostKeyChecking=no参数让ssh默认添加新主机的公钥指纹
    # 防止出现是否继续yes/no的提示
    expect -c "
        set timeout -1;
        spawn -noecho ssh -o StrictHostKeyChecking=no $2 ${@:3};
        expect *assword:*;
        send -- $1\r;
        interact;"
}

# Main函数
#
HOST=`echo $1 | tr '[:upper:]' '[:lower:]'`
CONFIG="/home/david/Documents/work/fangdd/hosts.config"
SCRIPT_NAME=`basename $0`

case ${HOST} in
    21)
        Hostname=$(load_config_key $CONFIG "21.hostname")
        Username=$(load_config_key $CONFIG "21.username")
        Password=$(load_config_key $CONFIG "21.password")

        auto_login_ssh "$Password" "$Username@$Hostname"
        ;;
    78)
        Hostname=$(load_config_key $CONFIG "78.hostname")
        Username=$(load_config_key $CONFIG "78.username")
        Password=$(load_config_key $CONFIG "78.password")

        auto_login_ssh "$Password" "$Username@$Hostname"
        ;;
    151)
        Hostname=$(load_config_key $CONFIG "151.hostname")
        Username=$(load_config_key $CONFIG "151.username")
        Password=$(load_config_key $CONFIG "151.password")

        auto_login_ssh "$Password" "$Username@$Hostname"
        ;;
    gw)
        Hostname=$(load_config_key $CONFIG "gw.hostname")
        Username=$(load_config_key $CONFIG "gw.username")
        Password=$2
        if [ -z "$Password" ]
        then
            echo "Password can not be empty!"
        fi

        #auto_login_ssh "$Password" "$Username@$Hostname"
        ;;
    *)
        echo
        echo "Usage: $SCRIPT_NAME {21|78|151|gw <key>}"
        ;;
esac

