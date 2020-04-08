#!/bin/bash
DEBUG="--debug"
#DEBUG=""
cd ..

cwl-runner $DEBUG  bandage-image.cwl -h




cwl-runner $DEBUG  bandage-image.cwl  \
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

