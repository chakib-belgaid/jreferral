#! /bin/bash

curdir="$(dirname -- $(readlink -fn -- "$0"; echo x))"
curdir="${curdir%x}"

IFS=$'\n'
jvms=$(grep -v "#" $curdir/jvms.sh | awk -F ' ' '{print $1'})


user=chakibmed

for jvm in ${jvms[@]}; do
    echo building jvm $jvm
    docker build --tag $user/jvm:$jvm --build-arg TAG="$jvm" -f $curdir/images-builder/baseimage.Dockerfile $curdir/images-builder

done
