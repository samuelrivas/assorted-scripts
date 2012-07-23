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

for i in src priv ebin include deps doc; do
    mkdir $DEST/$i;
    touch $DEST/$i/.gitignore;
done

# --------------------------------------------------------------------
# Create standard gitignore
# --------------------------------------------------------------------
cp $TEMPLATES/erlang-rebarised-gitignore $DEST/.gitignore

# --------------------------------------------------------------------
# Create standard rebar.config
# --------------------------------------------------------------------
cp $TEMPLATES/rebar.config $DEST/rebar.config

# --------------------------------------------------------------------
# Put the last rebar there
# --------------------------------------------------------------------
REBAR_URL=https://github.com/basho/rebar/wiki/rebar

echo
echo "Downloading $REBAR_URL ..."
wget $REBAR_URL -O $DEST/rebar -nv
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
# overview.edoc
# --------------------------------------------------------------------
sed -e "s/@@APP_NAME@@/$APP_NAME/g" \
    < $TEMPLATES/erlang-overview-edoc.template \
    > $DEST/doc/overview.edoc

# --------------------------------------------------------------------
# Git init and initial commit
# --------------------------------------------------------------------
OLDPWD=$PWD
cd $DEST
git init --quiet
git add .
git commit -m "Initial commit"  --quiet
cd $OLDPWD

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
