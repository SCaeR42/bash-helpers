#!/bin/bash
set -euo pipefail

#base settings
## current dir
DIRSCRIPT=$(cd "$(dirname "$0")" && pwd)
DEST_HELPER_DIR='.helpers'
FILE_BUNDLE='bash_helpers_bundle.sh'
FILE_BUNDLE_PATCH="$DIRSCRIPT/$DEST_HELPER_DIR/$FILE_BUNDLE"
FILE_LOCAL='local_aliases.sh'

#created bundle dir
mkdir -p "$DIRSCRIPT/$DEST_HELPER_DIR"

#combine all helpers to bundle
echo 'Start combine helpers'

#header + truncate bundle file
{
    echo "#!/bin/bash"
    echo "# ВНИМАНИЕ: файл сгенерирован build.sh — не редактировать вручную"
    echo "# $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
} > "$FILE_BUNDLE_PATCH"

count=0
for dir in "$DIRSCRIPT"/helpers/*/; do
    for script in "$dir"*.sh; do
        [ -f "$script" ] || continue
        rel=${script#"$DIRSCRIPT"/}
        {
            echo "# ───────── $rel ─────────"
            # убрать первую строку-шебанг у каждого файла
            sed '1{/^#!\/bin\/bash/d}' "$script"
            echo ""
        } >> "$FILE_BUNDLE_PATCH"
        count=$((count + 1))
    done
done
echo "End combine helpers ($count files)"

cp "$DIRSCRIPT/local/$FILE_LOCAL" "$DIRSCRIPT/$DEST_HELPER_DIR/"
