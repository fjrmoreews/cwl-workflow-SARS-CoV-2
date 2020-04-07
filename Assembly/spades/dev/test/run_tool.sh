DEBUG="--debug"
#DEBUG=""
cd ..
rm run_spades.sh
rm spades_launch.sh
#cwl-runner spades.cwl --h
cwl-runner $DEBUG  spades.cwl  \
  --cov_state 'auto' \
  --nanopore_reads   $PWD/test/test-data/ecoli_1K_1.fasta \
  --pacbio_reads  $PWD/test/test-data/x/ecoli_1K_1x.fq \
  --sanger_reads  $PWD/test/test-data/ecoli_1K_1.fq \

#  --libraries_metadata.lib_index 2 \
#  --libraries_metadata.orientation fr \
#  --libraries_metadata.lib_type mate_paired \
#  --libraries_fwd_rev.lib_index 2 \
#  --libraries_fwd_rev.fwd_reads $PWD/test/test-data/x/ecoli_1K_FW_x.fq \
#  --libraries_fwd_rev.rev_reads $PWD/test/test-data/x/ecoli_1K_REV_x.fq


#  --libraries_metadata.lib_index 1 \
#  --libraries_metadata.orientation fr  \
#  --libraries_metadata.lib_type paired_end \
#  --libraries_mono.lib_index 1 \
#  --libraries_mono.file_type unpaired \
#  --libraries_mono.reads  $PWD/test/test-data/x/ecoli_1K_1xx.fq  \
 
 
# \
#  --trusted_contigs  $PWD/test/test-data/ecoli_1K_1.fasta  


# --fastq_file_type paired \
# --mode  normal \
# --fastq1 $PWD/test/test-data/phix_f.fq.gz   --fastq1_type=fastqsanger \
# --fastq2 $PWD/test/test-data/phix_r.fq.gz   --fastq2_type=fastqsanger

cat zz.txt
#rm zz.txt
 
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

