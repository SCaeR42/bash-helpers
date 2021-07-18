#!/bin/bash

#base settings
## current dir
DIRSCRIPT=$(cd $(dirname $0) && pwd)
DEST_HELPER_DIR='.helpers'
FILE_BUNDLE='bash_helpers_bundle.sh'
FILE_BUNDLE_PATCH=$DIRSCRIPT/$DEST_HELPER_DIR/$FILE_BUNDLE
FILE_LOCAL='local_aliases.sh'

#created bundle dir
if [ ! -d $DIRSCRIPT/$DEST_HELPER_DIR ]; then
    mkdir $DIRSCRIPT/$DEST_HELPER_DIR
    echo 'Created dir: ' $DIRSCRIPT/$DEST_HELPER_DIR;
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

cp local/$FILE_LOCAL $DEST_HELPER_DIR


