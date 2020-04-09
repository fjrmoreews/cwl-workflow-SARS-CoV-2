## Variation
 https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics/4-Variation

### FASTP

### MULTIQC : html files from FASTP

### SNPEFF BUILD

The command used in this Variation Workflow is "snpEff build -genbank".

First, we will generate a cwl tool to execute this specific function of snpEff (and snpEff build) in order be able to reproduce the Variation Workflow, then proceed with generalization.

#### 1- snpEff Build Database in "Variation"

![SNPEFF1.png](:/bbea8f0cac904109a883a9b42c340a8c)
(https://usegalaxy.org/u/aun1/w/covid-19-se-var)
(https://usegalaxy.org/u/aun1/w/covid-19-variation-analysis)

Name for the database
    covid-19
Input annotations are in
    GenBank
Genbank dataset to build database from
    Output dataset 'output' from step 2
Parse Genbank into Fasta
    Yes
Remove sequence version label?
    True
Select genetic code for this sequence
    Standard

#### 2- XML tool Galaxy snpEff Build
https://github.com/galaxyproject/tools-iuc/blob/master/tool_collections/snpeff/snpEff_create_db.xml
##### IN:
- genome_version = "covid-19"
- input_type.input_type_selector = gb
- input_type.input_gbk = file from GenBank (format: genbank or genbank.gz)
- input_type.fasta = no
- input_type.remove-version = true
- input_type.codon_table = "Standard"

##### OUT:
At the beginning of the code, gbk2fa.py is executed to get output_fasta
- snpeff_output
- output_fasta

#### 3- Rebuild the command

ln -s FILE snpeff_output/covid19/genes.gbk(or gbk.gz) &&
snpEff @JAVA_OPTIONS@ build -v  -configOption covid19.genome='covid19'  -configOption 'covid19'.codonTable='Standard' -genbank  -dataDir snpeff_output 'covid19' &&
echo "covid19.genome : covid19" >> snpeff_output/snpEff.config &&
echo "covid19.codonTable : Standard" >> snpeff_output/snpEff.config

##### Conclusion > Use InitialWorkDirReq for mkdir & ln & echo and baseCommand for snpEff build
snpbuild doesn't have any output.

### BOWTIE2
#### 1- build 
bowtie2_build OK
#### 2- align
bowtie2_build's outputs can't be bowtie2_align or bowtie2 's inputs.
Some changes have been made in order to concatenate this two steps.

### PICARD: Mark Duplicates 
https://github.com/galaxyproject/tools-iuc/blob/master/tools/picard/picard_MarkDuplicates.xml
##### IN :
-
-
-
-
-
-
##### OUT :
- metrics_file .txt
- outFile .bam

Error: Exception in thread "main" picard.PicardException: This program requires input that are either coordinate or query sorted (according to the header, or at least ASSUME_SORT_ORDER and the content.) 

>> "Galaxy automatically coordinate-sorts all uploaded BAM files." 
Galaxy doesn't explicitely mention how BAM files are coordinate-sorted.
We will use : Picard SortSam Sort SAM/BAM by coordinate or queryname.

### PICARD: SortSAm
https://github.com/galaxyproject/tools-iuc/blob/master/tools/picard/picard_SortSam.xml
