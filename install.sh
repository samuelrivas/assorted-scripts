#!/bin/sh

BASE_DIR=$PWD/`dirname $0`

for i in $BASE_DIR/epstopdf $BASE_DIR/*.sh $BASE_DIR/*.rb; do
    if [ `basename $i` != "install.sh" ]; then
	ln -fs $i $BASE_DIR/..
    fi
done
