#!/bin/sh

tmprepo="/tmp/homedir_install.tmp.$RANDOM"

if [ -e $tmprepo ]
then
    rm -rf $tmprepo
fi

mkdir $tmprepo;
pushd $tmprepo;
git clone git://github.com/savonarola/homedir.git
perl install.pl
popd
rm -Rf $tmprepo

