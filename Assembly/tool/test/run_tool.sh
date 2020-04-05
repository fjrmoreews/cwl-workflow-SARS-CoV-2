DEBUG="--debug"
DEBUG=""
cd ..
cwl-runner $DEBUG  unicycler.cwl  \
 --fastq_file_type paired \
 --mode  normal \
 --fastq1 $PWD/test/test-data/phix_f.fq.gz   --fastq1_type=fastqsanger \
 --fastq2 $PWD/test/test-data/phix_r.fq.gz   --fastq2_type=fastqsanger

 
OUTDIR=result
mkdir -p $OUTDIR
rm $OUTDIR/*

ASSEMBLY=assembly.fasta

if [ -f "$ASSEMBLY" ]; then
    echo "$FILE exist"
    mv $ASSEMBLY $OUTDIR/ 
    mv assembly.gfa $OUTDIR/
    mv unicycler_launch.sh $OUTDIR/

fi

ls -l  $OUTDIR/

