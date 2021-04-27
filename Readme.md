# JVM-Selctor 
A tool that run your java program through multiple versions of JVMs and optimisation options to rcommend the most energry efficiant configuration 

## Requirements 
- **Docker** : we use a docker image for testing and isolating the JVM 
- **Linux** : Our tool is based on *RAPL* sensors to measure energy 
- **Python 3.5+** : for the reporting purpose 


## How to use 

1. Choose your options in th file `jvms.sh` 
    - uncomment what should be included during the tests
2. run `build-images.sh` that will build the docker images for respective jvms 
3. replace the word **java** with **./test.sh** in your command 
    - example 
        ``` 
        java -jar example.jar arg1 arg2 ...
        will be 
        ./test.sh -jar example.jar arg1 arg2 ...
        ```
you will find the results in `data.csv` and the execution log in `exp.log`

# TODO 
- [ ] add thepython script that print the choice 
- [x] Change the extension of jvms.sh 
- [ ] Custumize the username
- [ ] Custiomize the data filename and logs filename 
