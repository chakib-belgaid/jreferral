20.0.2-amzn
# 20.0.1-amzn
# 17.0.8-amzn
# 17.0.7-amzn
# 11.0.20-amzn
# 11.0.19-amzn
# 8.0.382-amzn
# 8.0.372-amzn
17.0.7-albba
# 11.0.19-albba
# 8.0.372-albba
# 8.0.275-albba
22.1.0.1.r17-gln
# 22.1.0.1.r11-gln
# 20.0.2-graalce
# 20.0.1-graalce
# 17.0.8-graalce
# 17.0.7-graalce
# 20.0.2-graal
# 20.0.1-graal
# 17.0.8-graal
# 17.0.7-graal
# 22.ea.7-open
# 22.ea.6-open
# 22.ea.5-open
# 22.ea.4-open
# 22.ea.3-open
# 21.ea.32-open
# 21.ea.31-open
# 21.ea.30-open
# 21.ea.29-open
# 21.ea.28-open
20.0.2-open
# 19.ea.1.pma-open
15.0.1-open
# 17.0.7-jbr
# 11.0.14.1-jbr
# 20.0.2.fx-librca
20.0.2-librca
# 20.0.1.fx-librca
# 20.0.1-librca
# 17.0.8.fx-librca
# 17.0.8-librca
# 17.0.7.fx-librca
# 17.0.7-librca
# 11.0.20.fx-librca
# 11.0.20-librca
# 11.0.19.fx-librca
# 11.0.19-librca
# 8.0.382.fx-librca
# 8.0.382-librca
# 8.0.372.fx-librca
# 8.0.372-librca
23.r20-nik
# 23.r17-nik
# 22.3.2.r17-nik
# 22.3.2.r11-nik
23.r20-mandrel
# 23.r17-mandrel
# 22.3.2.1.r17-mandrel
# 17.0.8-ms
# 17.0.7-ms
# 11.0.20-ms
# 11.0.19-ms
20.0.2-oracle
# 20.0.1-oracle
# 17.0.8-oracle
# 17.0.7-oracle
20.0.2-sapmchn
# 20.0.1-sapmchn
# 17.0.8-sapmchn
# 17.0.7-sapmchn
# 11.0.20-sapmchn
# 11.0.19-sapmchn
20.0.1-sem
# 17.0.7-sem
# 11.0.19-sem
# 8.0.372-sem
# 20.0.2-tem
# 20.0.1-tem
# 17.0.8-tem
# 17.0.7-tem
# 11.0.20-tem
# 11.0.19-tem
# 8.0.382-tem
# 8.0.372-tem
17.0.8-kona
# 17.0.7-kona
# 11.0.20-kona
# 11.0.19-kona
# 8.0.382-kona
# 8.0.372-kona
# 11.0.15-trava
# 8.0.282-trava
# 20.0.2-zulu
20.0.2.fx-zulu
# 20.0.1-zulu
# 20.0.1.fx-zulu
# 17.0.8-zulu
# 17.0.8.crac-zulu
17.0.8.fx-zulu
# 17.0.7-zulu
# 17.0.7.crac-zulu
# 17.0.7.fx-zulu
# 11.0.20-zulu
# 11.0.20.fx-zulu
# 11.0.19-zulu
# 11.0.19.fx-zulu
# 8.0.382-zulu
# 8.0.382.fx-zulu
# 8.0.372-zulu
# 8.0.372.fx-zulu
# 7.0.352-zulu
# 6.0.119-zulu

# ### JIT
# 20.2.0.r11-grl
# 20.2.0.r11-grl -XX:-UseJVMCICompiler
# 20.2.0.r11-grl -Dgraal.CompilerConfiguration=community
# 20.2.0.r11-grl -Dgraal.CompilerConfiguration=economy

# 15.0.1.j9-adpt
# 15.0.1.j9-adpt -XcompilationThreads1
# 15.0.1.j9-adpt -XcompilationThreads3
# 15.0.1.j9-adpt -XcompilationThreads7
# 15.0.1.j9-adpt -Xjit:count=0
# 15.0.1.j9-adpt -Xjit:count=1
# 15.0.1.j9-adpt -Xjit:count=10
# 15.0.1.j9-adpt -Xjit:count=100
# 15.0.1.j9-adpt -Xjit:optlevel=cold
# 15.0.1.j9-adpt -Xjit:optlevel=warm
# 15.0.1.j9-adpt -Xjit:optlevel=hot
# 15.0.1.j9-adpt -Xjit:optlevel=veryhot
# 15.0.1.j9-adpt -Xjit:optlevel=scorching

15.0.1-open
# 15.0.1-open -XX:-TieredCompilation
# 15.0.1-open -XX:TieredStopAtLevel=0
# 15.0.1-open -XX:TieredStopAtLevel=1
15.0.1-open -XX:TieredStopAtLevel=2
# 15.0.1-open -XX:TieredStopAtLevel=3
# 15.0.1-open -XX:TieredStopAtLevel=4
# 15.0.1-open -XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:-UseJVMCICompiler

# #### Garbage Collector

# 20.2.0.r11-grl -XX:+UseG1GC
# 20.2.0.r11-grl -XX:ParallelGCThreads=5
# 20.2.0.r11-grl -XX:ConcGCThreads=5
# 20.2.0.r11-grl -XX:ParallelGCThreads=1
# 20.2.0.r11-grl -XX:ConcGCThreads=1
# 20.2.0.r11-grl -XX:+DisableExplicitGC
# 20.2.0.r11-grl -XX:+UseParallelGC
# 20.2.0.r11-grl -XX:+UseParallelOldGC
# 20.2.0.r11-grl -XX:MaxGCPauseMillis=5000 -XX:GCTimeRatio=2

# 15.0.1.j9-adpt -Xgc:concurrentScavenge
# 15.0.1.j9-adpt -Xgc:scvNoAdaptiveTenure
# 15.0.1.j9-adpt -Xgcpolicy:balanced
# 15.0.1.j9-adpt -Xgcpolicy:gencon
# 15.0.1.j9-adpt -Xgcpolicy:metronome
# 15.0.1.j9-adpt -Xgcpolicy:nogc
# 15.0.1.j9-adpt -Xgcpolicy:optavgpause
# 15.0.1.j9-adpt -Xgcpolicy:optthruput

# 15.0.1-open -XX:+UseG1GC
# 15.0.1-open -XX:ParallelGCThreads=5
# 15.0.1-open -XX:ConcGCThreads=5
# 15.0.1-open -XX:ParallelGCThreads=1
# 15.0.1-open -XX:ConcGCThreads=1
# 15.0.1-open -XX:+DisableExplicitGC
# 15.0.1-open -XX:+UseParallelGC
# 15.0.1-open -XX:+UseParallelOldGC
# 15.0.1-open -XX:+UseSerialGC
# 15.0.1-open -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -XX:+AlwaysPreTouch
