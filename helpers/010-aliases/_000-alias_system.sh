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


