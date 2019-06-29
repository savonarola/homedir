#!/bin/bash

tmprepo="/tmp/homedir_install.tmp.$RANDOM"

if [ -e $tmprepo ]
then
    rm -rf $tmprepo
fi

mkdir $tmprepo
pushd $tmprepo || exit 1
git clone git://github.com/savonarola/homedir.git
perl homedir/install.pl
popd || exit 1
rm -Rf $tmprepo

