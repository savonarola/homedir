#!/bin/bash
version=$1

if [ "x$version" == "x" ]
then
  echo "Usage: $0 VERSION"
  exit 1
fi

tmprepo="/tmp/homedir_install.tmp.$RANDOM"

if [ -e $tmprepo ]
then
    rm -rf $tmprepo
fi

mkdir $tmprepo
pushd $tmprepo || exit 1
wget "https://github.com/savonarola/homedir/archive/v$version.tar.gz"
tar xf "v$version.tar.gz"
cd "homedir-$version" || exit 1
perl ./install.pl
popd || exit 1
rm -Rf $tmprepo

