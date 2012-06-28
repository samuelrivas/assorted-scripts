#!/bin/sh
#
# This deletes everything that is not under version control

git clean -dfx
git submodule foreach --recursive git clean -dfx
