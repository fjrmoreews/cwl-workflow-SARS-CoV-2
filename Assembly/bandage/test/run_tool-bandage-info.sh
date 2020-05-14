#!/bin/bash
#DEBUG="--debug"
DEBUG=""
cd ..
CWL="../../bio-cwl-tools/bandage/bandage-info.cwl"
cwl-runner  $CWL -h

cwl-runner  --outdir ./result  $DEBUG  $CWL  \
 --tsv  \
 --graph $PWD/test/test-data/gfa.tabular 
 
OUTDIR=result

if [ -d "$OUTDIR" ]; then
    echo "dir $OUTDIR exists "
    ls -l   $OUTDIR/
fi
