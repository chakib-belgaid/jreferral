#! /bin/bash
IFS=$'\n'
jvms=$(grep -v "#" images-builder/jvms.sh | awk -F ' ' '{print $1'})

user=chakibmed

for jvm in ${jvms[@]}; do
    echo building jvm $jvm
    docker build --tag $user/jvm:$jvm --build-arg TAG="$jvm" -f images-builder/baseimage.Dockerfile images-builder

done
