import sys
import pandas as pd
from tabulate import tabulate
import argparse
import matplotlib as mpl
from matplotlib import pyplot as plt
from itertools import cycle
from matplotlib.patches import Patch
from matplotlib.backends.backend_pdf import PdfPages
import os
import logging
import numpy as np

logger = logging.getLogger('mylogger')
# set logger level
logger.setLevel(logging.WARNING)

mpl.rcParams['axes.titlesize'] = 30
mpl.rcParams['axes.titlepad'] = 22
mpl.rcParams['axes.labelsize'] = 30
mpl.rcParams['axes.labelpad'] = 20
mpl.rcParams['xtick.labelsize'] = 15
mpl.rcParams['ytick.labelsize'] = 20
mpl.rcParams['axes.grid'] = True

# labelpad
# mpl.rc('axes',titlesize= 30)

# mpl.rc('xtick', labelsize=22)
# mpl.rc('ytick', labelsize=22)
TITLSEDIC = {'duration': 'Execution Time (s)', 'CPU': 'Energy CPU (J)',
             'DRAM': 'Energy DRAM (J)', 'energy': 'Total Energy (J)',
             'jvm': 'JVM', 'options': 'Execution Flags'}

palette = ["#D6CADD",
           "#3B0D6E",
           "#3240AB",
           "#0095B6",
           "#72A0C1",
           "#7EECE5",
           "#05B881",
           "#49796B",
           "#E2DC4C",
           "#E0542A",
           "#A83731",
           "#2E3544",
           "#AC2269"
           ]


def read_tags():
    # with open() :
    pathname = os.path.dirname(sys.argv[0])
    configfile = os.path.join(pathname, "jvms-option-names.sh")
    with open(configfile, 'r') as f:
        lines = [x.strip() for x in f.readlines() if x[0] != '#']
        lines = [x for x in lines if x != '']
        tags = {x.split(' TAG ')[0]: x.split(' TAG ')
                [1].lstrip() for x in lines}
        tags['default'] = ''
        return tags


TAGS = read_tags()
undifinedOptions = []

pd.options.mode.chained_assignment = None


def get_recap(x, metrics):
    recap = pd.DataFrame()
    mins = x.min(numeric_only=True)
    maxs = x.max(numeric_only=True)
    means = x.mean(numeric_only=True)
    stds = x.std(numeric_only=True)
    for metric in metrics:
        mini = x.loc[x[metric] == mins[metric]]
        mini["Metric"] = TITLSEDIC[metric]
        recap = recap._append(mini)
        recap["Type"] = "Best"

    for metric in metrics:
        maxi = x.loc[x[metric] == maxs[metric]]
        maxi["Metric"] = TITLSEDIC[metric]
        recap = recap._append(maxi)

    recap = recap._append(maxi)
    recap.reset_index(inplace=True)
    means["Type"] = "Mean"
    stds["Type"] = "STD"
    means["Metric"] = "All"
    stds["Metric"] = "All"
    recap = recap._append(means, ignore_index=True)
    recap = recap._append(stds, ignore_index=True)
    recap = recap.set_index(["Type", "Metric"]).loc[:,
                                                    metrics+["jvm", "options"]]
    recap.rename(columns=TITLSEDIC)
    recap = recap.fillna('')
    return recap


def highlight_max(s):
    is_max = np.logical_and(
        s == s[:-1].max(), s.apply(lambda x: type(x) is float))
    return ['color: red' if v else '' for v in is_max]


def highlight_min(s):

    is_min = np.logical_and(
        s == s[:-1].min(), s.apply(lambda x: type(x) is float))
    return ['color: green' if v else '' for v in is_min]


def plot_box(df, metric, axes):
    colors = dict(zip(df["distribution"].unique(), cycle(palette)))
    legends = [Patch(facecolor=color, label=distribution)
               for distribution, color in colors.items()]

    fig = df.boxplot(by="name", column=metric, ax=axes, rot=-90,
                     return_type="both", showfliers=False,
                     backend='matplotlib')
    # inside the boxplots

    for i in range(len(fig[0][1]['boxes'])):
        jvm = fig[0][0].get_xticklabels()[i].get_text().split(" ")[1]
        distribution = get_distribution(jvm)
        color = colors[distribution]
        fig[0][1]['boxes'][i].set(color=color, linewidth=2)
        fig[0][1]['medians'][i].set(color="red", linewidth=1)
    for i in range(len(fig[0][1]['whiskers'])):
        fig[0][1]['whiskers'][i].set(color=color, linewidth=1)
        fig[0][1]['caps'][i].set(color=color, linewidth=1)

    axes.set_ylabel(ylabel=TITLSEDIC[metric])
    axes.get_figure().suptitle('')
    axes.set_xlabel(xlabel='')
    axes.set_title('')
    axes.legend(handles=legends, fontsize=25,
                loc='center left', bbox_to_anchor=(1.0, 0.5))
    axes.set_xticklabels([' '.join(x.get_text().split(' ')[1:])
                         for x in axes.get_xticklabels()])
    return axes


def get_distribution(jvm):
    s = jvm.split("-")[-1]
    if s == "grl":
        version = jvm.split(".")[0]
        s = f"grl-{version}"
    elif s == "adpt":
        s = jvm.split(".")[-1]

    return s


def get_version(jvm):
    s = jvm.split("-")[-1]
    jvm = jvm.split("-")[0]
    if s == "grl":
        s = jvm.split(".")[-1].replace("r", "")
    elif s == "albba":
        s = jvm.split(".")[0].split("u")[0]
    elif s == "mandrel":
        s = 11
    else:
        s = jvm.split(".")[0]
    try:
        s = int(s)
    except ValueError:
        s = 0
    return s


def plot_data(df, path, metrics):
    # path=os.path.join(path,f"{bench}.pdf")
    pp = PdfPages(path)
    for metric in metrics:
        fig, axes = plt.subplots(1, 1, figsize=(50, 20))
        _ = plot_box(df, metric, axes)
        pp.savefig(fig, bbox_inches='tight')
        plt.savefig(path+metric+".png", format="png", bbox_inches='tight')

    pp.close()


def read_data(path):

    data = pd.read_csv(path, sep=";")
    data = data.dropna()
    data = data.loc[data["exitcode"] == 0]

    data["CPU"] = data["CPU"]/1000000
    data["DRAM"] = data["DRAM"]/1000000
    data["duration"] = data["duration"]/1000000
    data["energy"] = data["CPU"]+data["DRAM"]
    data["distribution"] = data["jvm"].apply(get_distribution)
    data["version"] = data["jvm"].apply(get_version)
    data["name"] = data.apply(
        lambda row:
            f"{(row['distribution'])} {row['jvm']} {get_tag(row['options'])} ",
            axis=1)

    data.sort_values(["distribution", "jvm"], inplace=True)
    return data


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('-d', '--details',
                        action='store_true',
                        default=False,
                        help='Print the energy PKG and DRAM in Details')

    parser.add_argument('-p', '--plot',
                        action='store_true',
                        default=False,
                        help='generate a pdf file for box plots of the test ')

    parser.add_argument("path", help="path of the csv file")

    args = parser.parse_args()
    data = read_data(args.path)
    path = os.path.dirname(args.path)
    metrics = ['duration', 'CPU', 'DRAM'] if args.details else [
        'duration', 'energy']
    maxi = max(data["iteration"].unique())
    uniqueBenchmark = False

    if "benchmark" not in data.columns:
        data["benchmark"] = os.path.basename(args.path).replace(".csv", "")
        uniqueBenchmark = True

    benchmarks = data["benchmark"].unique()
    listBenchmarks = {}
    listRecaps = []
    length = len(data["name"].unique())

    for bench in benchmarks:
        dt = data.loc[data["benchmark"] == bench]
        listBenchmarks[bench] = dt
        recapbench = get_recap(dt, metrics)
        recapbench["benchmark"] = bench

        listRecaps.append(recapbench)
    recap = pd.concat(listRecaps)
    recap.reset_index(inplace=True)
    recap = recap.set_index("benchmark")
    recap.reset_index(inplace=True)
    if args.plot:
        basePath = os.path.dirname(args.path)
        filename = "" if uniqueBenchmark else os.path.basename(
            args.path).replace(".csv", "_")
        for bench, df in listBenchmarks.items():
            path = os.path.join(basePath, f"{filename}{bench}.pdf")
            plot_data(df, path, metrics)

        print(f"Number of configurations : {length } \n"
              f"Number of executions per configuration : {maxi}\n"
              f"The best confifuration based on the median")

    print(tabulate(recap, headers=recap.columns,
          showindex=False, tablefmt="fancy_grid"))


def get_tag(options):

    try:
        tag = TAGS[options.lstrip()]
    except KeyError:
        tag = options.lstrip()
        if not (tag in undifinedOptions):
            undifinedOptions._append(tag)
            logger.warning(
                f"""Warrning --  The options : [{options}] has no Tag,\
                    hence it will take the option as a tag.
                Please consider adding an apropriate tag in \
                    the jvms-options-names.sh file""")

    finally:
        return tag


if __name__ == "__main__":
    main()
