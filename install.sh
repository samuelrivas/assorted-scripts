#!/bin/sh

BASE_DIR=$PWD/`dirname $0`

for i in $BASE_DIR/*.sh; do
    ln -fs $i $BASE_DIR/..
done
