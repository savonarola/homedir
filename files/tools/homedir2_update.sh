#!/bin/sh

tmprepo="/tmp/homedir2.tmp"
curdir=$(pwd)

if [ -e "$tmprepo" ]
then
    rm -Rf "$tmprepo"
fi
git clone git://github.com/savonarola/homedir2.git "$tmprepo"
cd "$tmprepo"
"$tmprepo"/install.pl "$@"
rm -Rf "$tmprepo"
cd "$curdir"

