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
