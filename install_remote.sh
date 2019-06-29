#!/bin/bash

host="$1"

if [ -z "$host" ]
then
    echo "Usage: $0 HOST"
    exit 1
fi

tmprepo="/tmp/homedir_install.tmp.$RANDOM"

if [ -e $tmprepo ]
then
    rm -rf $tmprepo
fi

mkdir $tmprepo
pushd $tmprepo || exit 1
git clone git://github.com/savonarola/homedir.git
tar czf homedir.tar.gz homedir
scp homedir.tar.gz "$host:homedir.tar.gz"
ssh "$host" tar xf homedir.tar.gz
ssh "$host" perl homedir/install.pl
popd || exit 1
rm -Rf $tmprepo

