#! /bin/bash

user="chakibmed"
datafile="data.csv"
logfile="exp.log"

IFS=$'\n'                                  # retrieve the whole line and ignore spaces
jvms=$(grep -v "#" images-builder/jvms.sh) # get the available jvm configurations
header=$(./measureit.sh -l)                # get the avialable domaines

measure() {
    tag=$1
    optionstag=$2
    shift 2
    cmd=$@
    #handle the default option
    if [ $optionstag == "deafult" ]; then
        options=""
    else
        options=$optionstag
    fi
    # launch the cmd using energy script
    IFS=$' '

    energies=$(./measureit.sh -b -o $logfile docker run --rm -it --entrypoint=/root/.sdkman/candidates/java/current/bin/java -v$(pwd):/lab -w /lab $user/jvm:$tag $options $cmd)

    IFS=$'\n'
    ## write the results in a data file
    numbers=$(parse_energies $energies)
    echo $tag';'$optionstag""$numbers >>$datafile

}

parse_energies() {
    #change the format for key;value into a csv format
    energies=$@

    echo | awk -v data=$energies -v header=$header 'BEGIN \
    {
        
        n=split(data,data1,";");
        split(header,header1,";");
        
        for (i = 1 ; i <= n; i+=2 ) {
            energies[data1[i]]=data1[i+1]  ;  
        }

        for (i in header1 ){
            printf ";"energies[header1[i]]
        }
    }'
}

#intialisation of the log and data files
echo "jvm;options;"$header >$datafile
echo "" >$logfile

#excuting the cmd

cmd=$@
for line in ${jvms[@]}; do
    echo $line
    tag=$(echo $line | awk -F ' ' '{print $1'})
    options=$(echo $line | awk -F ' ' '{for (i=2; i <= NF; i++) printf " "$i ;}')
    if [ -z $options ]; then
        options="deafult"
    fi
    measure $tag $options $cmd
done
