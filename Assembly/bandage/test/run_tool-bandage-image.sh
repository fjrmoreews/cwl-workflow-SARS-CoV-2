#!/bin/bash
DEBUG="--debug"
#DEBUG=""
cd ..
CWL="../../bio-cwl-tools/bandage/bandage-image.cwl"

cwl-runner  $CWL -h


cwl-runner $DEBUG  $CWL  \
 --graph $PWD/test/test-data/gfa.tabular \
 --format png \
 --height 2500  \
 --node_name  \
 --node_length  


 
OUTDIR=result

if [ -d "$OUTDIR" ]; then
    echo "dir $OUTDIR exists : deleting it"
    rm -f  $OUTDIR/*
    mkdir -p $OUTDIR
    mv *png $OUTDIR/ 
    mv bandage_image_launch.sh $OUTDIR/
    ls -l  $OUTDIR/
fi

