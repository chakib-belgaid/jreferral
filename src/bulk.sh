#! /bin/bash

user="chakibmed"
datafile="data.csv"
logfile="exp.log"
max_iterations=10
sleep_duration=3
opt_dec=0
tt=""
while getopts "du:o:l:n:" o >/dev/null 2>&1; do
    case "${o}" in
    u)
        user=${OPTARG}
        ;;
    o)
        datafile=${OPTARG}
        ;;
    l)
        logfile=${OPTARG}
        ;;
    n)
        max_iterations=${OPTARG}
        ;;
    s)
        sleep_duration=${OPTARG}
        ;;
    d)
        details="True"
        ;;

    ?)
    ?)
        tt="True"
        ;;

    esac
done

if [ -n "$tt" ]; then

    shift $((OPTIND - 2))

else
    shift $((OPTIND - 1))

fi

benchmarksfile=$1

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
    benchname=$3
    optionstag=$4
    shift 4
    cmd=$@
    #handle the default option
    if [ $optionstag == "default" ]; then
        options=""
    else
        options=$optionstag
    fi
    # launch the cmd using energy script
    echo -------$tag----$iteration---$optionstag--- >>$logfile
    IFS=$' '

    energies=$($curdir/measureit.sh -c -o $logfile docker run --rm -it --entrypoint=/root/.sdkman/candidates/java/current/bin/java -v$(pwd):/lab -w /lab $user/jvm:$tag $options $cmd)
    exitcode=$?
    IFS=$'\n'
    ## write the results in a data file
    numbers=$(parse_energies $energies)
    echo $benchname';'$tag';'$optionstag';'$iteration';'$exitcode''$numbers >>$datafile

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
echo "benchmark;jvm;options;iteration;exitcode;"$header >$datafile
echo "" >$logfile

#excuting the cmd

for i in $(seq 1 1 $max_iterations); do
    for benchmark in $(grep -v "#" $benchmarksfile); do

        for line in ${jvms[@]}; do
            IFS=$' '
            benchname=$(echo $benchmark | cut -d " " -f3)
            IFS=$'\n'

            echo $line -- $benchname -- $i

            tag=$(echo $line | awk -F ' ' '{print $1'})
            options=$(echo $line | awk -F ' ' '{for (i=2; i <= NF; i++) printf " "$i ;}')
            if [ -z $options ]; then
                options="default"
            fi
            measure $i $tag $benchname $options $benchmark
            sleep $sleep_duration
        done
    done
done

if [ -n "$details" ]; then

    python3 $curdir/recap.py -d -b $datafile
else

    python3 $curdir/recap.py $datafile
fi
