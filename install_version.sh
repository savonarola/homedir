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
wget "https://github.com/savonarola/homedir/archive/v$HOMEDIR_VERSION.tar.gz"
tar xf "v$HOMEDIR_VERSION.tar.gz"
cd "homedir-$HOMEDIR_VERSION"
perl homedir/install.pl
popd
rm -Rf $tmprepo
