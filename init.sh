#!/bin/sh

## current dir
DIRSCRIPT=$(cd $(dirname $0) && pwd)
DEST_HELPER_DIR='.helpers'

#remotes
REMOTE_BUNDLE_DIR='https://raw.githubusercontent.com/spacecoding42/bash-helpers/master'
REMOTE_DIR_DIST=$REMOTE_BUNDLE_DIR/'.helpers'
FILE_BUNDLE='bash_helpers_bundle.sh'
FILE_LOCAL='local_aliases.sh'


#create .helpers dir in user bash_profile
cd ~ && mkdir $DEST_HELPER_DIR

#copy files
wget $REMOTE_DIR_DIST/$FILE_BUNDLE -O ~/$DEST_HELPER_DIR/000-$FILE_BUNDLE
wget $REMOTE_DIR_DIST/$FILE_LOCAL -O ~/$DEST_HELPER_DIR/$FILE_LOCAL

#remove init file
rm -fr $DIRSCRIPT/init.sh

#create bash_profile in not exist
if [ ! -f ~/.bash_profile ]; then
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
	echo ".bash_profile file create";
fi

#enabled files on .bash_profile
if [ -f ~/.bash_profile ]; then
if grep -Eq '##### BASH HELPERS #####' ~/.bash_profile; then
echo ".helpers found in .bash_profile file";
else
cat >> ~/.bash_profile << \EOF
##### BASH HELPERS #####
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for script in ~/.helpers/*.sh ; do
    if [ -f $script ] ; then
        . $script
    fi
done

EOF
echo ".bash_helpers added to .bash_profile file";
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

