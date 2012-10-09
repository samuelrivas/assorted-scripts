#!/bin/sh
# This is the script run by jenkins to verify this module

set -e

echo "============================================================"
echo " Cleaning previous artifacts"
echo "============================================================"
git clean -dfx

echo "============================================================"
echo " Compling datetime"
echo "============================================================"
make compile

echo "============================================================"
echo " Creating the documentation to check it builds correctly"
echo "============================================================"
make docs

echo "============================================================"
echo " Static checks for datetime"
echo "============================================================"
make check

echo "============================================================"
echo " Unit testing datetime"
echo "============================================================"
make test
