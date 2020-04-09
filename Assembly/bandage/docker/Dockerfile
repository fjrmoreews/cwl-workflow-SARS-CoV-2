FROM ubuntu:19.04

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update 
RUN apt-get install -y  build-essential git qtbase5-dev libqt5svg5-dev g++
RUN apt-get purge -y libc6-dev && apt-get install -y  libc6-dev  
WORKDIR /work


RUN apt-get install -y zip wget  qt5-qmake qt5-default  
  

RUN wget https://github.com/rrwick/Bandage/releases/download/v0.8.1/Bandage_Ubuntu_static_v0_8_1.zip

RUN  unzip  Bandage_Ubuntu_static_v0_8_1.zip && \
   rm Bandage_Ubuntu_static_v0_8_1.zip && cp Bandage /usr/bin/ &&  chmod +x /usr/bin/Bandage 




RUN export QT_QPA_PLATFORM=offscreen && \
    TMPDIR=$PWD"/tmp_runtime-bandage" && \
    mkdir -p $TMPDIR && \
    export XDG_RUNTIME_DIR=$TMPDIR && \
    GRAPH=sample_LastGraph && \
    Bandage info $GRAPH  --tsv > assembly_graph_info.txt



