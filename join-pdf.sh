#!/bin/sh

if [ $# -lt 3 ]; then
    echo
    echo "Usage `basename $0` <output-file> <pdf-file-2> <pdf-file-1>" \
	"[<pdf-files>]"
    echo
    exit
fi

OUTPUT=$1
shift

pdftk $* cat output $OUTPUT

echo
echo "Done! You've got your new pdf file in $OUTPUT"
echo