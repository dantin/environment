#! /bin/bash

cd /home/david/Temp/socket

# 开SSH隧道
open_tunnel(){
    case $1 in
        s1)
            # tunnel to s1
            ssh -M -S s1_socket -p55522 -N -f -L 22221:s1_xf:22 xfsh@211.144.118.119
            ;;
        s2)
            # tunnel to s2
            ssh -M -S s2_socket -p55522 -N -f -L 22222:s2_xf:22 xfsh@211.144.118.119
            ;;
        *)
            echo "error in open tunnel"
            ;;
    esac
}

check_tunnel(){
    case $1 in
        s1)
            ssh -S s1_socket -O check xfsh@211.144.118.119
            ;;
        s2)
            ssh -S s2_socket -O check xfsh@211.144.118.119
            ;;
        *)
            echo "error in check tunnel"
            ;;
    esac
}

close_tunnel(){
    case $1 in
        s1)
            ssh -S s1_socket -O exit xfsh@211.144.118.119
            ;;
        s2)
            ssh -S s2_socket -O exit xfsh@211.144.118.119
            ;;
        *)
            echo "error in close tunnel"
            ;;
    esac
}

# Main函数
#
SCRIPT_NAME=`basename $0`

case $1 in
    open)
        echo "Open tunnel to $2"
        open_tunnel $2
        ;;
    check)
        echo "Check tunnel to $2"
        check_tunnel $2
        ;;
    close)
        echo "Close tunnel to $2"
        close_tunnel $2
        ;;
    *)
        echo
        echo "Usage: $SCRIPT_NAME {open|check|close} {s1|s2}"
        ;;
esac
