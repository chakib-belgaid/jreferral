-XX:-TieredCompilation TAG No JIT
-XX:TieredStopAtLevel=0 TAG JIT not Tired
-XX:TieredStopAtLevel=1 TAG JIT lvl 1
-XX:TieredStopAtLevel=2 TAG JIT lvl 2
-XX:TieredStopAtLevel=3 TAG JIT lvl 3
-XX:TieredStopAtLevel=4 TAG JIT lvl 4
-XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:-UseJVMCICompiler TAG JIT Graal

-XX:-UseJVMCICompiler TAG DisableJVMCI
-Dgraal.CompilerConfiguration=economy TAG JIT Economy
-Dgraal.CompilerConfiguration=community TAG JIT Community

-XcompilationThreads1 TAG JIT 1Threads
-XcompilationThreads3 TAG JIT 3Threads
-XcompilationThreads7 TAG JIT 7Threads
-Xjit:count=0 TAG JIT Count 0
-Xjit:count=1 TAG JIT Count 1
-Xjit:count=10 TAG JIT Count 10
-Xjit:count=100 TAG JIT Count 100
-Xjit:optlevel=cold TAG JIT Cold
-Xjit:optlevel=warm TAG JIT Warm
-Xjit:optlevel=hot TAG JIT Hot
-Xjit:optlevel=veryhot TAG JIT Veryhot
-Xjit:optlevel=scorching TAG JIT Scorching

-XX:+UseG1GC TAG GC G1
-XX:ParallelGCThreads=5 TAG GC 5 Parallel
-XX:ConcGCThreads=5 TAG GC 5 Concurent
-XX:ParallelGCThreads=1 TAG GC Parallel
-XX:ConcGCThreads=1 TAG GC Concurent
-XX:+DisableExplicitGC TAG GC DisableExplicitGC
-XX:+UseParallelGC TAG GC ParallelGC
-XX:+UseParallelOldGC TAG GC ParallelOldGC
-XX:MaxGCPauseMillis=5000 -XX:GCTimeRatio=2 TAG GC Pause

-Xgc:concurrentScavenge TAG GC ConcurrentScavenge
-Xgc:scvNoAdaptiveTenure TAG GC ScvNoAdaptiveTenure
-Xgcpolicy:balanced TAG GC Balanced
-Xgcpolicy:gencon TAG GC Gencon
-Xgcpolicy:metronome TAG GC Metronome
-Xgcpolicy:nogc TAG GC NoGC
-Xgcpolicy:optavgpause TAG GC PauseGC
-Xgcpolicy:optthruput TAG GC Optthrought

# Just a comment

-XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -XX:+AlwaysPreTouch TAG GC EpsilonGC

-XX:+UseSerialGC TAG GC Serial
