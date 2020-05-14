#!/bin/bash
DEBUG="--debug"
#DEBUG=""
cd ..
CWL="../../bio-cwl-tools/bandage/bandage-image.cwl"

cwl-runner  $CWL -h


cwl-runner  --outdir ./result $DEBUG  $CWL  \
 --graph $PWD/test/test-data/gfa.tabular \
 --format png \
 --height 2500  \
 --node_name  \
 --node_length  


 
OUTDIR=result

if [ -d "$OUTDIR" ]; then
    echo "dir $OUTDIR exists "
    ls -l  $OUTDIR/
fi

