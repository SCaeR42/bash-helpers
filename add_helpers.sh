#!/bin/bash

## current dir
DIRSCRIPT=$(cd $(dirname $0) && pwd)
echo "${DIRSCRIPT}"

## add helpers

# recreate bash_profile
# rm -f ~/.helpers;

# ln -sv $DIRSCRIPT/helpers ~/.helpers

. ~/bash_helpers/helpers/000-main/_colors.sh
. ~/bash_helpers/helpers/000-main/_functions.sh

# ubuntu add comand column (fixed it: column: command not found)
# apt-get install bsdmainutils
# added our system helpers & aliases to bash_profile
if [ -f ~/.bash_profile ]; then
	_info "${_Yellow}.bash_profile${_Cyan} file ${_Yellow}found";
else
	touch  ~/.bash_profile;
cat >> ~/.bash_profile << \EOF
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

EOF
	_info "${_Yellow}.bash_profile${_Cyan} file ${_Yellow}create";
fi

if [ -f ~/.bash_profile ]; then
if grep -Eq 'bash_helpers/helpers/bash_helpers.sh' ~/.bash_profile; then
_info "${_Yellow}.bash_helpers found${_Cyan} in .bash_profile file";
else
# cat >> ~/.bash_profile << \EOF
# if [ -f ~/bash_helpers ]; then
#     . ~/bash_helpers
# fi
# EOF
# _info "${_Yellow}.bash_helpers added${_Cyan} to .bash_profile file";
cat >> ~/.bash_profile << \EOF
if [ -f ~/bash_helpers/helpers/bash_helpers.sh ]; then
	. ~/bash_helpers/helpers/bash_helpers.sh
fi
EOF
_info "${_Yellow}.bash_helpers added${_Cyan} to .bash_profile file";
fi
fi

## add dotfiles
# for script in $DIRSCRIPT/dotfiles/.* ; do
# 	if [ -f $script ] ; then
# 		scriptName=$(basename $script)
# 		if [ -h $scriptName ] ; then
# 			rm ~/$scriptName
# 			_info "${_Cyan}simlink: ${_Yellow}$scriptName${_Cyan} deleted";
# 		fi
# 		if [ -f $scriptName ] ; then
# 			mv ~/$scriptName ~/old_$scriptName
# 			_info "${_Cyan}file: ${_Yellow}$scriptName${_Cyan} moved";
# 		fi
# 		ln -s $DIRSCRIPT/dotfiles/$scriptName ~/$scriptName
# 		_info "${_Cyan}create simlink: ${_Yellow}$scriptName";
# 	fi
# done




