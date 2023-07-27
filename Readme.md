# JReferral  
A tool that run your java program through multiple versions of JVMs and optimisation options to recommand the most energry efficiant configuration.  

## Requirements 
- **Docker** : we use a docker image for testing and isolating the JVM 
- **Linux** : Our tool is based on *RAPL* sensors to measure energy 
- **Python 3.5+** : for the reporting purpose 


## How to use 

1. Choose The configurations to be tested  in th file [jvms.sh](./src/jvms.sh) 
    - Uncomment what should be included during the tests

2. Run [build-images.sh](./src/buildi-images.sh) that will build the docker images for respective jvms 
    - You can add the option **-u** to setup the  username for docker images 
    - The images will have the format***username/jvm:version**
3. Replace the word **java** with **src/jrecommand.sh** in your command 
    - Example 
        ``` 
        java -jar example.jar arg1 arg2 ...
        will be 
        ./jreferral.sh -jar example.jar arg1 arg2 ...
        ```

You will find the results in `data.csv` and the execution log in `exp.log`

### Note: 
Due to security reasons, you need sudo access in order to measure the energy  

## Bulk Benchmarking 

If you want to test multiple benchmarks you can use [bulk.sh](./src/bulk.sh), to do So

1. Put your benchmarks in a file as an exmple `example_bulks.sh` 

2. Run the script [bulk.sh](./src/bulk.sh) giving him as entry the path of your *bulks_file*
    - Example
        ``` 
        ./src/bulk.sh example_bulks.sh
        ```
## Plotting the results 

With the option `-p` the program will generate a pdf file containaing all the measures aka *execution time* and *energies* for each benchmark. 

- In order to have more visible name for the different tunning options you can put them in the [tagging file](src/jvms-option-names.sh) using the following format 

    `options` **TAG** `visible tag` 
    
- Example:
    ```
    -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -XX:+AlwaysPreTouch TAG EpsilonGC
    ```
The tests with this options will take the name of EpsilonGC in the graphs 
## Flags and options 

- For both `jreferral.sh` and `bulk.sh`

|**Flag**|**Description**|**Default value**|
|--------|---------------|:---------------:|
| -u *name* | The username of docker images | user |
| -o *filename* | The filename where the all the measures should be put in | data.csv|
| -l *filename* | Redirection of the output of the tests | exp.log |
| -n *Number* | The number of iterations that should be run for each configuration | 1 | 
| -s *Duration* | Time to wait between two consecutive tests (in order to avoid the test impacting each others ) | 3s | sec|
| -d | print the *DRAM* energy and *CPU* energy seperately | False | 
| -p | generate a *pdf* that containes all the measures in format of boxplot  | False | 



## Example
### Recap

This is an example to test the energy consumption of [zip4j](https://github.com/srikanth-lingala/zip4j)


![zip4j](https://github.com/chakib-belgaid/jreferral/blob/master/imgs/zip4j.png?raw=true)

and for the detailed version (aka -d)


![zip4j detailed ](https://github.com/chakib-belgaid/jreferral/blob/master/imgs/zip4jdetailed.png?raw=true)


### Plots 


Energy consumption of  **CPU** 

![zip4j](https://github.com/chakib-belgaid/jreferral/blob/master/imgs/zip4j_1_CPU.png?raw=true)



Energy consumption of  **DRAM** 

![zip4j](https://github.com/chakib-belgaid/jreferral/blob/master/imgs/zip4j_1_DRAM.png?raw=true)


**Execution of Time** 

![zip4j](https://github.com/chakib-belgaid/jreferral/blob/master/imgs/zip4j_1_duration.png?raw=true)

