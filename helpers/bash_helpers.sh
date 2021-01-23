#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for dir in ~/bash_helpers/helpers/* ; do
        if [ -d $dir ] ; then
                for script in $dir/*.sh ; do
						if [ -f $script ] ; then
								. $script
						fi
				done
        fi
done


for script in ~/bash_helpers/local/* ; do
        if [ -f $script ] ; then
                . $script
        fi
done
