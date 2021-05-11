
import sys 
import pandas  as pd 
from  tabulate import tabulate
import argparse

pd.options.mode.chained_assignment = None

def get_recap_details(x):
    recap=pd.DataFrame()
    mins=x.min()
    maxs=x.max()
    means=x.mean()
    stds=x.std()

    mini=x.loc[x["duration"]==mins["duration"]]
    mini["Metric"]="Execution Time"
    recap=recap.append(mini)
    mini=x.loc[x["CPU"]==mins["CPU"]]
    mini["Metric"]="Energy PKG"
    recap=recap.append(mini)
    mini=x.loc[x["DRAM"]==mins["DRAM"]]
    mini["Metric"]="Energy DRAM"
    recap=recap.append(mini)
    recap["Type"]="Best"
    
    maxi=x.loc[x["duration"]==maxs["duration"]]
    maxi["Metric"]="Execution Time"
    maxi["Type"]="Worst"
    recap=recap.append(maxi)

    maxi=x.loc[x["CPU"]==maxs["CPU"]]
    maxi["Metric"]="Energy PKG"
    maxi["Type"]="Worst"
    recap=recap.append(maxi)
    maxi=x.loc[x["DRAM"]==maxs["DRAM"]]
    maxi["Metric"]="Energy DRAM"
    maxi["Type"]="Worst"
    recap=recap.append(maxi)
    recap.reset_index(inplace=True)  
    means["Type"]="Mean"
    stds["Type"]="STD"
    means["Metric"]="All"
    stds["Metric"]="All"
    recap=recap.append(means,ignore_index=True)
    recap=recap.append(stds,ignore_index=True)
    recap=recap.set_index(["Type","Metric"]).loc[:,["duration","CPU","DRAM","jvm","options"]]
    recap["duration"]=recap["duration"]/1000000
    recap["CPU"]=recap["CPU"]/1000000
    recap["DRAM"]=recap["DRAM"]/1000000
    recap.columns=["Execution Time (s)","Energy CPU (J)","Energy DRAM (J)", "JVM","Execution Flags"]
    recap=recap.fillna('')
    return recap

def get_recap(x):
    recap=pd.DataFrame()
    mins=x.min()
    maxs=x.max()
    means=x.mean()
    stds=x.std()

    mini=x.loc[x["duration"]==mins["duration"]]
    mini["Metric"]="Execution Time"
    recap=recap.append(mini)
    mini=x.loc[x["energy"]==mins["energy"]]
    mini["Metric"]="Energy"
    recap=recap.append(mini)
    recap["Type"]="Best"
    
    maxi=x.loc[x["duration"]==maxs["duration"]]
    maxi["Metric"]="Execution Time"
    maxi["Type"]="Worst"
    recap=recap.append(maxi)
    maxi=x.loc[x["energy"]==maxs["energy"]]
    maxi["Metric"]="Energy"
    maxi["Type"]="Worst"
    recap=recap.append(maxi)
    recap.reset_index(inplace=True)  
    means["Type"]="Mean"
    stds["Type"]="STD"
    means["Metric"]="All"
    stds["Metric"]="All"
    recap=recap.append(means,ignore_index=True)
    recap=recap.append(stds,ignore_index=True)
    recap=recap.set_index(["Type","Metric"]).loc[:,["duration","energy","jvm","options"]]
    recap["duration"]=recap["duration"]/1000000
    recap["energy"]=recap["energy"]/1000000
    recap.columns=["Execution Time (s)","Total Energy (J)", "JVM","Execution Flags"]
    recap=recap.fillna('')
    return recap

def highlight_max(s):
    is_max = np.logical_and(s == s[:-1].max()  ,s.apply(lambda x:type(x) is float))
    return ['color: red' if v else '' for v in is_max]

def highlight_min(s):

    is_min =np.logical_and(s == s[:-1].min()  ,s.apply(lambda x:type(x) is float)) 
    return ['color: green' if v else '' for v in is_min]



def read_data(path):
    data=pd.read_csv(path,sep=";",dtype={"jvm":str,"options":str,"iteration":"Int64","exitcode":"Int64"
                                     ,"duration":"Int64",
                                     "DRAM":"Int64","CPU":"Int64"})
    data=data.dropna()
    data=data.loc[data["exitcode"]==0]
    data["energy"]=data["CPU"]+data["DRAM"]
    return data

if __name__=="__main__" :
    parser = argparse.ArgumentParser() 
    parser.add_argument('-d','--details',
        action='store_true',
        default=False,
        help='Print the energy PKG and DRAM in Details')
    parser.add_argument('-b','--bulk',
        action='store_true',
        default=False,
        help='only use with the script bulk.sh')
    parser.add_argument("path", help="path of the csv file")
    
    args = parser.parse_args()
    data=read_data(args.path)
    maxi=max(data["iteration"].unique())
    if args.bulk :
        benchmarks=data["benchmark"].unique()
        l=[]
        length=0
        for bench in benchmarks :
            dt=data.loc[data["benchmark"]==bench]
            recapbench=get_recap_details(dt) if args.details else get_recap(dt)
            recapbench["benchmark"]=bench
            length=max(length,len(recapbench))
            l.append(recapbench)
        recap = pd.concat(l)
        recap = recap.set_index("benchmark")

    else :
        x=data.groupby(["jvm","options"]).median()
        recap=get_recap_details(x) if args.details else get_recap(x)
        length=(len(x))
    recap.reset_index(inplace=True)
    print(f"Number of configurations : {length } \nNumber of executions per configuration : {maxi}\nThe best confifuration based on the median")
    
    print(tabulate(recap,headers =recap.columns,showindex = False,tablefmt="fancy_grid"))