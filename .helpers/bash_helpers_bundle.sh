#!/bin/bash
# colors
#Памятка, Таблица цветов и фонов
#Цвет           код       код фона

#black    30  40    \033[30m  \033[40m
#red      31  41    \033[31m  \033[41m
#green    32  42    \033[32m  \033[42m
#yellow    33  43    \033[33m  \033[43m
#blue    34  44    \033[34m  \033[44m
#magenta    35  45    \033[35m  \033[45m
#cyan    36  46    \033[36m  \033[46m
#white    37  47    \033[37m  \033[47m

#showed all colors
colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo
        echo
    done
}

# Сброс
_Norm='\e[0m'       # Text Reset

# Обычные цвета
_Black='\e[0;30m'        # Black
_Red='\e[0;31m'          # Red
_Green='\e[0;32m'        # Green
_Yellow='\e[0;33m'       # Yellow
_Blue='\e[0;34m'         # Blue
_Purple='\e[0;35m'       # Purple
_Cyan='\e[0;36m'         # Cyan
_White='\e[0;37m'        # White

# Жирные
_BBlack='\e[1;30m'       # Black
_BRed='\e[1;31m'         # Red
_BGreen='\e[1;32m'       # Green
_BYellow='\e[1;33m'      # Yellow
_BBlue='\e[1;34m'        # Blue
_BPurple='\e[1;35m'      # Purple
_BCyan='\e[1;36m'        # Cyan
_BWhite='\e[1;37m'       # White

# Подчёркнутые
_UBlack='\e[4;30m'       # Black
_URed='\e[4;31m'         # Red
_UGreen='\e[4;32m'       # Green
_UYellow='\e[4;33m'      # Yellow
_UBlue='\e[4;34m'        # Blue
_UPurple='\e[4;35m'      # Purple
_UCyan='\e[4;36m'        # Cyan
_UWhite='\e[4;37m'       # White

# Фоновые
_On_Black='\e[40m'       # Black
_On_Red='\e[41m'         # Red
_On_Green='\e[42m'       # Green
_On_Yellow='\e[43m'      # Yellow
_On_Blue='\e[44m'        # Blue
_On_Purple='\e[45m'      # Purple
_On_Cyan='\e[46m'        # Cyan
_On_White='\e[47m'       # White

# Высоко Интенсивные
_IBlack='\e[0;90m'       # Black
_IRed='\e[0;91m'         # Red
_IGreen='\e[0;92m'       # Green
_IYellow='\e[0;93m'      # Yellow
_IBlue='\e[0;94m'        # Blue
_IPurple='\e[0;95m'      # Purple
_ICyan='\e[0;96m'        # Cyan
_IWhite='\e[0;97m'       # White

# Жирные Высоко Интенсивные
_BIBlack='\e[1;90m'      # Black
_BIRed='\e[1;91m'        # Red
_BIGreen='\e[1;92m'      # Green
_BIYellow='\e[1;93m'     # Yellow
_BIBlue='\e[1;94m'       # Blue
_BIPurple='\e[1;95m'     # Purple
_BICyan='\e[1;96m'       # Cyan
_BIWhite='\e[1;97m'      # White

# Высоко Интенсивные фоновые
_On_IBlack='\e[0;100m'   # Black
_On_IRed='\e[0;101m'     # Red
_On_IGreen='\e[0;102m'   # Green
_On_IYellow='\e[0;103m'  # Yellow
_On_IBlue='\e[0;104m'    # Blue
_On_IPurple='\e[0;105m'  # Purple
_On_ICyan='\e[0;106m'    # Cyan
_On_IWhite='\e[0;107m'   # White

#!/bin/bash
# export
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# SSH
export SSH="$HOME/.ssh"

export EDITOR=nano


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

#!/bin/bash
# aliases system
alias rm='rm -i'
alias cp='cp -i'
# Предотвращает случайное удаление файлов.
alias mv='mv -i'
alias mkdir='mkdir -p'

# simlink
alias ln='ln -v'
alias lns='ln -sv'

# routing
alias h='history'
alias j='jobs -l'
alias which='type -all'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kTh'

# Customized ls
alias ll='ls -l'                # файлы столбиком
alias la='ls -Al'               # показать скрытые файлы
alias ls='ls -hF --color'       # выделить различные типы файлов цветом
alias lx='ls -lXB'              # сортировка по расширению
alias lk='ls -lSr'              # сортировка по размеру
alias lc='ls -lcr'              # сортировка по времени изменения
alias lu='ls -lur'              # сортировка по времени последнего обращения
alias lr='ls -lR'               # рекурсивный обход подкаталогов
alias lt='ls -ltr'              # сортировка по дате
alias lm='ls -al |more'         # вывод через 'more'
alias tree='tree -Csu'          # альтернатива 'ls'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# tail
alias tailF="sudo tail -fn 50 $1"

# очистка истории команд
alias ahc='echo -n >~/.bash_history && echo -n >~/.bash_history && history -c -w && echo Готово!!!!!'

# CentOS
alias yumi='yum install -y'

#systemctl
alias ss='systemctl status'
alias sr='systemctl restart'
alias str='systemctl start'
alias sst='systemctl stop'
alias se='systemctl enable'
alias sd='systemctl disable'



#!/bin/bash
#git
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"

alias gs='git status'
alias ga='git add'
alias gac='git add .;git commit -a'
alias gacm='git add .;git commit -a -m'
alias gcm='git commit --amend'
alias gu='git config user.name; git config user.email'
alias gl='git log'
alias gpush='git push'
alias gpull='git pull'

alias gi='echo "
gb		-	git branch
gc		-	git commit
gd		-	git diff
gco		-	git checkout
gs		-	git status
ga		-	git add .
gac		-	git add .;git commit -a
gacm		-	git add .;git commit -a -m
gcm		-	git commit --amend
gu		-	git config user.name; git config user.email
gl		-	git log
gpush		-	git push
gpull		-	git pull"
'

#!/bin/bash
#laravel
alias lvl='php artisan $1'
alias lvllist='lvl list'
alias lvlclear='lvl cache:clear | lvl debugbar:clear | lvl view::clear'

#!/bin/bash
echo -e "${_Cyan}Open shell help info ${_Yellow}bh${_Norm}";



