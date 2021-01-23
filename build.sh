#!/bin/sh

#base settings
## current dir
DIRSCRIPT=$(cd $(dirname $0) && pwd)
DIR_DIST='.helpers'
FILE_BUNDLE='bash_helpers_bundle.sh'
FILE_BUNDLE_PATCH=$DIRSCRIPT/$DIR_DIST/$FILE_BUNDLE

#created bundle dir
if [ ! -d $DIRSCRIPT/$DIR_DIST ]; then
    mkdir $DIRSCRIPT/$DIR_DIST
    echo 'Created dir: ' $DIRSCRIPT/$DIR_DIST;
fi

#created bundle file
if [ ! -f $FILE_BUNDLE_PATCH ]; then
	touch  $FILE_BUNDLE_PATCH;
	echo 'Created file: ' $FILE_BUNDLE_PATCH;
fi

#truncate bundle file
> $FILE_BUNDLE_PATCH

#combine all helpers to bundle
echo 'Start combine helpers';

cat $DIRSCRIPT/helpers/ >> $FILE_BUNDLE_PATCH


for dir in $DIRSCRIPT/helpers/* ; do
        if [ -d $dir ] ; then
                for script in $dir/*.sh ; do
						if [ -f $script ] ; then
								cat $script >> $FILE_BUNDLE_PATCH
								echo '' >> $FILE_BUNDLE_PATCH
						fi
				done
        fi
done
echo 'End combine helpers';

cp local/local_aliases.sh $DIR_DIST

