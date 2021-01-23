#!/bin/bash
# functions
###############################################################################
# HELP FUNCTIONS
################################################################################
function _print() {
    printf "${_Norm}%s${_Norm}\n" "$@"
}
function _info() {
    printf "${_Cyan}➜ %s${_Norm}\n" "$@"
}
function _success() {
    printf "${_Green}✓ %s${_Norm}\n" "$@"
}
function _warning() {
    printf "${_Yellow}⚠ %s${_Norm}\n" "$@"
}
function _error() {
    printf "${_Red}✗ %s${_Norm}\n" "$@"
}

################################################################################
# MAIN FUNCTIONS
################################################################################

# os type
function _getDistName() {
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux" /etc/issue || grep -Eq "Red Hat Enterprise Linux" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Amazon Linux" /etc/issue || grep -Eq "Amazon Linux" /etc/*-release; then
        DISTRO='Amazon'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    elif grep -Eqi "Deepin" /etc/issue || grep -Eq "Deepin" /etc/*-release; then
        DISTRO='Deepin'
        PM='apt'
    elif grep -Eqi "Mint" /etc/issue || grep -Eq "Mint" /etc/*-release; then
        DISTRO='Mint'
        PM='apt'
    elif grep -Eqi "Kali" /etc/issue || grep -Eq "Kali" /etc/*-release; then
        DISTRO='Kali'
        PM='apt'
    else
        DISTRO='unknow'
    fi
}
_getDistName

# running on exit
function _exit() {
    echo -e "${_Red}exit ...${_Yellow}"
}

function my_ip() { # IP адрес
    MY_IP=$(/sbin/ifconfig eth0 | grep 'inet ' | awk '{ print $2}')
}

function domens() { # домены
    httpd -S | awk '/vhosts/ { print "|,", $4, ",|,", $5, ",|"} ' | column -s ',' -t
}

function domens2() { # домены
    find /etc/httpd/conf/vhosts/* -maxdepth 1 -type f | xargs cat || awk '/www/ { print "|,", $2, ",|"} ' | column -s ',' -t
}

function ii() { # Дополнительные сведения о системе
    echo -e "${_Green}====================== ${_BRed} Вы находитесь на ${_Green}=========================${_Yellow}" | column -s ',' -t
    hostname -f
    echo -e "${_Green}================= ${_BRed} Дополнительная информация: ${_Green}===================${_Norm}" | column -s ',' -t
    uname -a
    cat $(ls /etc/*{-,_}{release,version} 2>/dev/null | head -n 1)
    echo -e "${_Green}============== ${_BRed} В системе работают пользователи: ${_Green}===============${_Norm} " | column -s ',' -t
    w -h
    echo -e "${_Green}=================== ${_BRed} Точное время на сервере ${_Green}===================${_Norm} " | column -s ',' -t
    date
    echo -e "${_Green}============================ ${_BRed} uptime ${_Green}===========================${_Norm} " | column -s ',' -t
    uptime
    echo -e "${_Green}============================ ${_BRed} Память ${_Green}============================${_Norm}" | column -s ',' -t
    free
    my_ip 2>&-
    echo -e "${_Green}=========================== ${_BRed} IP адрес ${_Green}===========================${_Norm}" | column -s ',' -t
    echo ${MY_IP:-"Соединение не установлено"}
    echo -e "${_Green}===================== ${_BRed} Место на дисках HDD ${_Green}======================${_Norm}" | column -s ',' -t
    df -h | sed -n '/^\/dev/p'
    echo -e "${_Green}======================= ${_BRed} Полный объем HDD ${_Green}=======================${_Norm}" | column -s ',' -t
    df -h
    echo -e "${_Green}=================== ${_BRed} Ошибки Буферизация Ядра ${_Green}====================${_Norm}" | column -s ',' -t
    dmesg | grep error
    echo -e "${_Green}============================ ${_BRed} DOCKER ${_Green}============================${_Norm}" | column -s ',' -t
    docker images
    echo -e "${_Green}============================ ${_BRed} DOCKER ${_Green}============================${_Norm}" | column -s ',' -t
    docker ps -a
    echo -e "${_Green}============================ ${_BRed} Nginx ${_Green}============================${_Norm}" | column -s ',' -t
    systemctl status nginx.service | grep Active | sed "s/Active:/${_Green}Nginx:${_Norm}/"
    systemctl status php-fpm | grep Active | sed "s/Active:/${_Green}Php-fpm:${_Norm}/"
}

function scmenu() {
    option=0
    until [ "$option" = "4" ]; do
        echo "  1.) Инфо по серверу"
        echo "  2.) Aliases"
        echo "  q.) Quit"

        echo -n "Enter choice: "
        read option
        echo ""
        case $option in
        1)
            ii
            ;;
        2)
            i
            ;;
        'q') break ;;
        *) tput setf 4 && echo "invalid option $REPLY" && tput setf 7 ;;
        esac
    done
}

alias m='scmenu'

## Все задачи CRON всех пользователей

# Определим нашу функцию вывода списка всех задач cron у всех пользователей
function allcrontab() {
    for user in $(cut -d':' -f1 /etc/passwd); do
        usercrontab=$(crontab -l -u ${user} 2>/dev/null)
        if [ -n "${usercrontab}" ]; then
            echo -e "${_Red}====== Start crontab for user ${_Norm}${_Green}${user}${_Norm} ${_Red}======${_Norm}"
            crontab -l -u ${user} | sed '/ *#/d; /^ *$/d'
            echo -e "${_Red}====== End crontab for user ${_Norm}${_Green}${user}${_Norm} ${_Red}========${_Norm}\n"
        fi
    done
}
## /Все задачи CRON всех пользователей
