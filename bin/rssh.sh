#!/bin/bash

# 加载公共函数脚本
source /home/david/.bin/config.sh

CONFIG="/home/david/Documents/work/fangdd/hosts.config"
SCRIPT_NAME=`basename $0`

# 自动登录函数
#
# 参数：
# password 密码
# host     远程机器，格式'user@host'
# target   登录目标目录，可选
#
auto_login_ssh(){
    # StrictHostKeyChecking=no参数让ssh默认添加新主机的公钥指纹
    # 防止出现是否继续yes/no的提示
    if [ -z $3 ]; then
        echo "GOTO \$HOME"
        expect -c "
            set timeout -1;
            spawn -noecho ssh -o StrictHostKeyChecking=no $2 ${@:3};
            expect *assword:*;
            send -- $1\r;
            interact;"
    else
        echo "GOTO $3"
        expect -c "
            set timeout -1;
            spawn -noecho ssh -o StrictHostKeyChecking=no $2;
            expect *assword:*;
            send -- $1\r;
            expect *~*;
            send -- \"cd $3\n\";
            interact;"
    fi
}

get_location(){
    if [ -z $2 ]; then
        echo ""
    else
        case $2 in
            app)
                echo $(load_config_key $CONFIG "$1.app")
                ;;
            log)
                echo $(load_config_key $CONFIG "$1.log")
                ;;
        esac
        echo ""
    fi
}

# Main函数
#
HOST=`echo $1 | tr '[:upper:]' '[:lower:]'`

case ${HOST} in
    21)
        Hostname=$(load_config_key $CONFIG "21.hostname")
        Username=$(load_config_key $CONFIG "21.username")
        Password=$(load_config_key $CONFIG "21.password")
        Dir=$(get_location "21" $2)
        ;;
    78)
        Hostname=$(load_config_key $CONFIG "78.hostname")
        Username=$(load_config_key $CONFIG "78.username")
        Password=$(load_config_key $CONFIG "78.password")
        Dir=$(get_location "78" $2)
        ;;
    151)
        Hostname=$(load_config_key $CONFIG "151.hostname")
        Username=$(load_config_key $CONFIG "151.username")
        Password=$(load_config_key $CONFIG "151.password")
        Dir=$(get_location "151" $2)
        ;;
    s1)
        Hostname=$(load_config_key $CONFIG "s1.hostname")
        Username=$(load_config_key $CONFIG "s1.username")
        Password=$(load_config_key $CONFIG "s1.password")
        Dir=$(get_location "s1" $2)
        ;;
    s2)
        Hostname=$(load_config_key $CONFIG "s2.hostname")
        Username=$(load_config_key $CONFIG "s2.username")
        Password=$(load_config_key $CONFIG "s2.password")
        Dir=$(get_location "s2" $2)
        ;;
    *)
        echo
        echo "Usage: $SCRIPT_NAME {21|78|151|s1} [app|log]"
        exit 1
        ;;
esac

if [ -z $Dir ]; then
    auto_login_ssh "$Password" "$Username@$Hostname"
else
    auto_login_ssh "$Password" "$Username@$Hostname" "$Dir"
fi

