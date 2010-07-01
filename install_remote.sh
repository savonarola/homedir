#!/bin/bash

prog=`basename "$0"`
usage="$prog [-f flag1] [-f flag2] ... host1 [chain_host2] [chain_host3] ..."
temp=`getopt -o f:h: --long help -n "$prog" -- "$@"`

if [ $? != 0 ] ; then exit 1 ; fi

eval set -- "$temp"

flags=""

while true ; do
	case "$1" in
		-f) flags="$flags $2" ; shift 2 ;;
        --help) echo "$usage"; exit;;
		--) shift ; break ;;
		*) echo "Internal error!" ; exit 1 ;;
	esac
done

ssh_hosts=""
i=1

for arg; do
    if [ $i == $# ]; then
        ssh_hosts="$ssh_hosts ssh $arg "
    else
        ssh_hosts="$ssh_hosts ssh -t -t $arg "
    fi
    let i++
done

if [ "${ssh_hosts}x" == "x" ]; then
    echo "$usage"
    exit 255
fi

echo $ssh_hosts

env_cmd='env LANG="C" LC_ALL="C" '
rm_cmd='rm -Rf savonarola-homedir2-*'
cd_cmd='cd `ls -d savonarola-homedir2*`'
deploy_cmd=" ${rm_cmd}; ${env_cmd} wget http://github.com/savonarola/homedir2/tarball/master -O homedir2.tar.gz && ${env_cmd} tar zxf homedir2.tar.gz && ${cd_cmd} && pwd && ${env_cmd} ./install.pl ${flags} remote"

$ssh_hosts "'$deploy_cmd'"

