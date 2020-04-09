#!/bin/bash
#DEBUG="--debug"
DEBUG=""
cd ..
CWL="../../bio-cwl-tools/bandage/bandage-info.cwl"
cwl-runner  $CWL -h

cwl-runner $DEBUG  $CWL  \
 --tsv  \
 --graph $PWD/test/test-data/gfa.tabular 
 
OUTDIR=result

if [ -d "$OUTDIR" ]; then
    echo "dir $OUTDIR exists : deleting it"
    rm   $OUTDIR/*
fi
mkdir -p $OUTDIR

ASSEMBLY_INF=assembly_graph_info.txt
if [ -f "$ASSEMBLY_INF" ]; then
    echo "$ASSEMBLY_INF exist"
    mv $ASSEMBLY_INF $OUTDIR/ 
    mv bandage_info_launch.sh $OUTDIR/
fi
ls -l  $OUTDIR/
