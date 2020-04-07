
cd ..
#OPT="--leave-tmpdir --leave-outputs --debug"
OPT=""

cwl-runner $OPT  ./spades_assembly_wf.cwl job-assembly.yml

#OUTDIR=result
#mkdir -p $OUTDIR
#rm $OUTDIR/*

#ASSEMBLY=assembly.fasta

#if [ -f "$ASSEMBLY" ]; then
#    echo "$FILE exist"
#    mv $ASSEMBLY $OUTDIR/ 
#    mv assembly.gfa $OUTDIR/
#    mv unicycler_launch.sh $OUTDIR/

#fi

#ls -l  $OUTDIR/
