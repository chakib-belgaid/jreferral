#! /bin/bash

while getopts "u:" o >/dev/null 2>&1; do
    case "${o}" in
    u)
        USERNAME=${OPTARG}
        ;;
    esac
done

export USERNAME=${USERNAME:-$USER}

curdir="$(dirname -- $(
    readlink -fn -- "$0"
    echo x
))"
curdir="${curdir%x}"
IFS=$'\n'
jvms=$(grep -v "#" $curdir/jvms.sh | awk -F ' ' '{print $1'})

for jvm in ${jvms[@]}; do
    echo building jvm $jvm
    docker build --tag $USERNAME/jvm:$jvm --build-arg TAG="$jvm" -f $curdir/images-builder/baseimage.Dockerfile $curdir/images-builder
done
