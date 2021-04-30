#! /bin/bash

user="chakibmed"
datafile="data.csv"
logfile="exp.log"
max_iterations=3
s=""
while getopts "u:d:l:n:" o >/dev/null 2>&1; do
    case "${o}" in
    u)
        user=${OPTARG}
        ;;
    d)
        datafile=${OPTARG}
        ;;
    l)
        logfile=${OPTARG}
        ;;
    n)
        max_iterations=${OPTARG}
        ;;
    *)
        OPTIND=$((OPTIND - 1))
        ;;
    esac

done
shift $OPTIND

curdir="$(dirname -- $(
    readlink -fn -- "$0"
    echo x
))"
curdir="${curdir%x}"
IFS=$'\n'                           # retrieve the whole line and ignore spaces
jvms=$(grep -v "#" $curdir/jvms.sh) # get the available jvm configurations
header=$($curdir/measureit.sh -l)   # get the avialable domaines

measure() {

    iteration=$1
    tag=$2
    optionstag=$3
    shift 3
    cmd=$@
    #handle the default option
    if [ $optionstag == "deafult" ]; then
        options=""
    else
        options=$optionstag
    fi
    # launch the cmd using energy script
    echo -------$tag----$iteration---$optionstag--- >>$logfile
    IFS=$' '

    energies=$($curdir/measureit.sh -b -o $logfile docker run --rm -it --entrypoint=/root/.sdkman/candidates/java/current/bin/java -v$(pwd):/lab -w /lab $user/jvm:$tag $options $cmd)

    IFS=$'\n'
    ## write the results in a data file
    numbers=$(parse_energies $energies)
    echo $tag';'$optionstag';'$iteration''$numbers >>$datafile

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
echo "jvm;options;iteration;"$header >$datafile
echo "" >$logfile

#excuting the cmd

cmd=$@
for i in $(seq 1 1 $max_iterations); do
    for line in ${jvms[@]}; do
        echo $line
        tag=$(echo $line | awk -F ' ' '{print $1'})
        options=$(echo $line | awk -F ' ' '{for (i=2; i <= NF; i++) printf " "$i ;}')
        if [ -z $options ]; then
            options="deafult"
        fi
        measure $i $tag $options $cmd
    done
done
