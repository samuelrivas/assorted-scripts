#!/bin/sh

BASE_DIR=$PWD/`dirname $0`

for i in $(find $BASE_DIR -maxdepth 1 -executable -type f); do
    if [ `basename $i` != "install.sh" ]; then
        ln -fs $i $BASE_DIR/..
    fi
done
