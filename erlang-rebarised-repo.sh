#!/bin/sh
#
# Generates an erlang header file template

set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
TEMPLATES="$SCRIPT_HOME/assorted-scripts/templates"
DEST=$1
APP_NAME=`basename $DEST`

if [ -z "$DEST" ]; then
    echo
    echo "usage: `basename $0` <dir>"
    echo
    exit 1
fi

# --------------------------------------------------------------------
# Create directory structure
# --------------------------------------------------------------------
mkdir $DEST

for i in src priv ebin include deps; do
    mkdir $DEST/$i;
    touch $DEST/$i/.gitignore;
done

# --------------------------------------------------------------------
# Create standard gitignore
# --------------------------------------------------------------------
cp $TEMPLATES/erlang-gitignore $DEST/.gitignore

# --------------------------------------------------------------------
# Create standard rebar.config
# --------------------------------------------------------------------
cp $TEMPLATES/rebar.config $DEST/rebar.config

# --------------------------------------------------------------------
# Put the last rebar there
# --------------------------------------------------------------------
wget https://github.com/basho/rebar/wiki/rebar -O $DEST/rebar
chmod u+x $DEST/rebar

# --------------------------------------------------------------------
# Scripts for CI systems
# --------------------------------------------------------------------
cp $TEMPLATES/rebarised-build-and-test.sh $DEST/build-and-test.sh
cp $TEMPLATES/git-clean-all.sh $DEST/clean-all.sh
chmod u+x $DEST/build-and-test.sh
chmod u+x $DEST/clean-all.sh

# --------------------------------------------------------------------
# app.src
# --------------------------------------------------------------------
sed -e "s/@@APP_NAME@@/$APP_NAME/g" \
    < $TEMPLATES/erlang-app-src.template \
    > $DEST/src/$APP_NAME.app.src

# --------------------------------------------------------------------
# Git init and initial commit
# --------------------------------------------------------------------
cd $DEST
git init
git add .
git commit -m "Initial commit"
cd -

# --------------------------------------------------------------------
# Some remarks
# --------------------------------------------------------------------
echo
echo "You have your new app in $DEST. Just remember:"
echo "  * To edit the app.src file"
echo "  * To edit the rebar.config if you want"
echo "  * To substitute the rebar binary if you want"
echo
echo "Now go start coding"
echo
