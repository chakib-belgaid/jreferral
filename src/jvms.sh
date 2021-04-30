16.0.0.j9-adpt
16.0.0.hs-adpt
11.0.11.j9-adpt
11.0.11.hs-adpt
11.0.10.j9-adpt
11.0.10.hs-adpt
8.0.292.j9-adpt
8.0.292.hs-adpt
8.0.282.j9-adpt
8.0.282.hs-adpt

11.0.9.4-albba
8.5.5-albba

16.0.1.9.1-amzn
16.0.0.36.1-amzn
15.0.2.7.1-amzn
11.0.11.9.1-amzn
11.0.10.9.1-amzn
8.292.10.1-amzn
8.282.08.1-amzn

16.0.0-zulu
16.0.0.fx-zulu
15.0.2.fx-zulu
11.0.11-zulu
11.0.10-zulu
11.0.10.fx-zulu
8.0.292-zulu
8.0.282-zulu
8.0.282.fx-zulu
7.0.302-zulu
7.0.292-zulu
6.0.119-zulu

16.0.1.fx-librca
16.0.1-librca
16.0.0.fx-librca
16.0.0-librca
11.0.11.fx-librca
11.0.11-librca
11.0.10.fx-librca
11.0.10-librca
8.0.292.fx-librca
8.0.292-librca
8.0.282.fx-librca
8.0.282-librca

21.1.0.r16-grl
21.1.0.r11-grl
21.1.0.r8-grl
21.0.0.2.r11-grl
21.0.0.2.r8-grl
20.3.2.r11-grl
20.3.2.r8-grl
20.3.1.2.r11-grl
20.3.1.2.r8-grl
19.3.6.r11-grl
19.3.6.r8-grl
19.3.5.r11-grl
19.3.5.r8-grl

17.ea.19-open
17.ea.6.lm-open
17.ea.2.pma-open

16-open
16.0.1-open
11.0.11-open
11.0.10-open
11.0.2-open
8.0.292-open
8.0.282-open
8.0.265-open
21.0.0.0-mandrel
20.3.1.2-mandrel
11.0.11.9.1-ms
11.0.10.9-ms
16-sapmchn
16.0.1-sapmchn
15.0.2-sapmchn
11.0.11-sapmchn
11.0.10-sapmchn
11.0.9-trava
8.0.232-trava

# JIT
20.2.0.r11-grl -XX:-UseJVMCICompiler
20.2.0.r11-grl -Dgraal.CompilerConfiguration=community
20.2.0.r11-grl -Dgraal.CompilerConfiguration=economy

15.0.1.j9-adpt -XcompilationThreads1
15.0.1.j9-adpt -XcompilationThreads3
15.0.1.j9-adpt -XcompilationThreads7
15.0.1.j9-adpt -Xjit:count=0
15.0.1.j9-adpt -Xjit:count=1
15.0.1.j9-adpt -Xjit:count=10
15.0.1.j9-adpt -Xjit:count=100
15.0.1.j9-adpt -Xjit:optlevel=cold
15.0.1.j9-adpt -Xjit:optlevel=warm
15.0.1.j9-adpt -Xjit:optlevel=hot
15.0.1.j9-adpt -Xjit:optlevel=veryhot
15.0.1.j9-adpt -Xjit:optlevel=scorching

15.0.1-open -XX:-TieredCompilation
15.0.1-open -XX:TieredStopAtLevel=0
15.0.1-open -XX:TieredStopAtLevel=1
15.0.1-open -XX:TieredStopAtLevel=2
15.0.1-open -XX:TieredStopAtLevel=3
15.0.1-open -XX:TieredStopAtLevel=4
15.0.1-open -XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:-UseJVMCICompiler

#### Garbage Collector

20.2.0.r11-grl -XX:+UseG1GC
20.2.0.r11-grl -XX:ParallelGCThreads=5
20.2.0.r11-grl -XX:ConcGCThreads=5
20.2.0.r11-grl -XX:ParallelGCThreads=1
20.2.0.r11-grl -XX:ConcGCThreads=1
20.2.0.r11-grl -XX:+DisableExplicitGC
20.2.0.r11-grl -XX:+UseParallelGC
20.2.0.r11-grl -XX:+UseParallelOldGC
20.2.0.r11-grl -XX:MaxGCPauseMillis=5000 -XX:GCTimeRatio=2

15.0.1.j9-adpt -Xgc:concurrentScavenge
15.0.1.j9-adpt -Xgc:scvNoAdaptiveTenure
15.0.1.j9-adpt -Xgcpolicy:balanced
15.0.1.j9-adpt -Xgcpolicy:gencon
15.0.1.j9-adpt -Xgcpolicy:metronome
15.0.1.j9-adpt -Xgcpolicy:nogc
15.0.1.j9-adpt -Xgcpolicy:optavgpause
15.0.1.j9-adpt -Xgcpolicy:optthruput

15.0.1-open -XX:+UseG1GC
15.0.1-open -XX:ParallelGCThreads=5
15.0.1-open -XX:ConcGCThreads=5
15.0.1-open -XX:ParallelGCThreads=1
15.0.1-open -XX:ConcGCThreads=1
15.0.1-open -XX:+DisableExplicitGC
15.0.1-open -XX:+UseParallelGC
15.0.1-open -XX:+UseParallelOldGC
15.0.1-open -XX:+UseSerialGC
15.0.1-open -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -XX:+AlwaysPreTouch
