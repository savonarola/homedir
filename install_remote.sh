#!/bin/sh


prog=`basename "$0"`
where="$1"
shift
flags="$1"

if [ "${where}x" == "x" ]; then
    echo "Usage: $prog user@host [flags]"
    exit 255
fi

env_cmd='env LANG="C" LC_ALL="C" '
rm_cmd='rm -Rf savonarola-homedir2-*'
cd_cmd='cd `ls -d savonarola-homedir2*`'
deploy_cmd=" ${rm_cmd}; ${env_cmd} wget http://github.com/savonarola/homedir2/tarball/master -O homedir2.tar.gz && ${env_cmd} tar zxf homedir2.tar.gz && ${cd_cmd} && pwd && ${env_cmd} ./install.pl ${flags} remote"

ssh "$where"  "$deploy_cmd"

