#!/bin/sh
version=$1

if [ "x$version" == "x" ]
then
  echo "version required"
  exit 1
fi

tmprepo="/tmp/homedir_install.tmp.$RANDOM"

if [ -e $tmprepo ]
then
    rm -rf $tmprepo
fi

mkdir $tmprepo;
pushd $tmprepo;
wget "https://github.com/savonarola/homedir/archive/v$version.tar.gz"
tar xf "v$version.tar.gz"
cd "homedir-$version"
perl homedir/install.pl
popd
rm -Rf $tmprepo

