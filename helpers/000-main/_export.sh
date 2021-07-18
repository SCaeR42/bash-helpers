#!/bin/bash
# export
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# colorize ls
LS_COLORS=$LS_COLORS:'di=1;34:ow=34;42;41:';export LS_COLORS
export LS_COLORS

# SSH
export SSH="$HOME/.ssh"

export EDITOR=nano

