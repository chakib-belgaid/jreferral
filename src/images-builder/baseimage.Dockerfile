FROM debian:10.3
RUN apt-get update && apt-get install -y zip unzip curl wget procps && \
    curl -s "https://get.sdkman.io" | bash && \
    /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh" 

ARG TAG 
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java $TAG" 

# ENTRYPOINT ["/root/.sdkman/candidates/java/current/bin/java","-jar","dacapo-9.12-MR1-bach.jar"