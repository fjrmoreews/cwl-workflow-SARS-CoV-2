class: CommandLineTool
cwlVersion: v1.0

id: unicycler
baseCommand:
  - bash
  - '-c'
inputs:


 
##tyoe selector
  - id: fastq_type
    type:
      type: enum
      symbols: [paired,single,paired_collection]
      name: fastq_type
##############

##input1

  - id: fastq1_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
      name: fastq_input1
      

  - id: fastq_input1
    type: File
    ##


##input2
  - id: fastq2_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
      name: fastq_input2

    
  - id: fastq_input2
    type: File
    


##1 input collection forward + reverse
  - id: fastq1_forward_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
      name: fastq1_forward_type

    
  - id: fastq1_forward
    type: File
    
    
  - id: fastq1_reverse_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
      name: fastq1_reverse_type

    
  - id: fastq1_reverse
    type: File

#sequence_long (optional)
  - id: sequence_long_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
        - fasta
      name: sequence_long_type

    
  - id: sequence_long
    type:  File 
#    
  - id: compute_slots
    type:  int
    default: 4
    

##mode selector
  - id: mode
    type:
      type: enum
      symbols: [conservative,normal,bold]
      name: mode


  - id: min_fasta_length
    type:  int
    default: 100

  - id: linear_seqs
    type:  int
    default: 0

  - id: min_anchor_seg_len
    type:  int
    default: 0


  - id: spades_no_correct
    type:  boolean
    default: false

 
  - id: spades_min_kmer_frac
    type:  float
    default: 0.2
    max: 1.0
    min: 0.0


  - id: spades_max_kmer_frac
    type:  float
    default: 0.95
    max: 1.0
    min: 0.0
  
  # check default values
  - id: spades_kmers
    type:  string
    default: "11,127"

  - id: spades_kmer_count
    type:  int
    default: 10
    min: 0
 
  - id: spades_depth_filter
    type:  float
    default: 0.25
    min: 0.0
    max: 1.0

  - id: spades_largest_component
    type:  boolean
    default: false


  - id: rotation_no_rotate
    type:  boolean
    default: false
    
  - id: rotation_start_genes
    type:  File? 

  - id: rotation_start_gene_id
    type:  float
    default: 90.0
    max: 0.0
    min: 100.0

  - id: rotation_start_gene_cov
    type:  float
    default: 95.0
    max: 0.0
    min: 100.0

  - id: pilon_no_pilon
    type:  boolean
    default: false

  - id: graph_clean_min_component_size
    type:  integer
    default: 1000
    min: 0
    
  - id: graph_clean_min_dead_end_size
    type:  integer
    default: 1000
    min: 0
    
  - id: lr_align_contamination
    type:  File?

  - id: lr_align_scores
    type:  string
    default: "3,-6,-5,-2"

  - id: lr_align_low_score
    type:  integer?

############"
##  - id: record_test
##    type:
##      type: record
##      name: tocontigs
##      fields:
##        - name: fileR1
##          type: File
##        - name: fileR2
##          type: File 
############""    
    
outputs:

  - id: assembly_graph
    type: File
    outputBinding:
      glob: assembly.gfa/*
      
  - id: assembly
    type: File
    outputBinding:
      glob: assembly.fasta/*
      
      
arguments:
  - countseqs.batch
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: unicycler_launch.sh
        entry: >
               #unicycler launcher
               ${
                  lncmd="" 
               }
               ###########################preparing input files
               ###################paired case
               ${
                     if (inputs.fastq_type =="paired"  ){
                      if( inputs.fastq1_type=='fastqsanger' ){
                          fq1 = "fq1.fastq"
                      }
                      else if( inputs.fastq1_type=='fastqsanger.gz' ){
                           fq1 = "fq1.fastq.gz"
                      }
                      
                      
                      if( inputs.fastq2_type=='fastqsanger' ){
                          fq2 = "fq2.fastq"
                       }
                       else if( inputs.fastq2_type=='fastqsanger.gz' ){
                           fq2 = "fq2.fastq.gz"
                        }
                      
                        lncmd+=" ln -s '$(inputs.fastq_input1.path)' $fq1 && "
                        lncmd+=" ln -s '$(inputs.fastq_input2.path)' $fq2 && "
        
                     }
                }
               ###################paired_collection case
               ${
                 if (inputs.fastq_type =="paired_collection"  ){
    
                  if( inputs.fastq1_forward_type=='fastqsanger' ){
                      fq1 = "fq1.fastq"
                  }
                  else if( inputs.fastq1_forward_type=='fastqsanger.gz' ){
                       fq1 = "fq1.fastq.gz"
                  }
                  
                  if( inputs.fastq1_reverse_type=='fastqsanger' ){
                      fq2 = "fq2.fastq"
                   }
                   else if( inputs.fastq1_reverse_type=='fastqsanger.gz' ){
                       fq2 = "fq2.fastq.gz"
                    }
                                  
                  lncmd+=" ln -s '${inputs.fastq1_forward}' $fq1 && "
                  lncmd+=" ln -s '${inputs.fastq1_reverse}' $fq2 && "
    
                 }
                }
                ###################single case
                ${
                if (inputs.fastq_type =="single"  ){
                  if( inputs.fastq1_type=='fastqsanger' ){
                      fq1 = "fq1.fastq"
                  }
                  else if( inputs.fastq1_type=='fastqsanger.gz' ){
                       fq1 = "fq1.fastq.gz"
                  }
                
                   lncmd+=" ln -s '$(inputs.fastq_input1.path)' $fq1 && "
    
                 }
                }
                ####### long reads
                ${
                  if (inputs.sequence_long !=null)
                      if (inputs.sequence_long_type=='fastqsanger'){
                               lr = "lr.fastq"
                      }
                      else if (inputs.sequence_long_type=='fastqsanger.gz') {
                               lr = "lr.fastq.gz"
                      }
                      else if (inputs.sequence_longg_type=='fasta') {
                               lr = "lr.fasta"
                      }
                
                      lncmd+=" ln -s '${long}' '$lr' && "
                  }
                }
                
                ###################link files
                $(lncmd)
                 ## Get location for pilon installation
                pilon=`pilon --jar_dir` &&
                ${
                ## Build Unicycler command
                cmd_base=""
                cmd_base+=" unicycler -t "${inputs.compute_slots}" \"
                cmd_base+=" -o ./ \"
                cmd_base+=" --verbosity 3 \"
                cmd_base+=" --pilon_path \$pilon \"
              
                if ( inputs.fastq_type == "paired"){
                       opt+=" -1 '"+fq1+"' -2 '"+fq2+"'  "
                else if ( inputs.fastq_type == "paired_collection"){
                       opt+=" -1 '"+fq1+"' -2 '"+fq2+"'  "
                else if ( inputs.fastq_type == "single"){
                   opt+=" -s '"+fq+"' "
                }
                if (sequence_long!=null){
                  opt+=" -l "+lr+" "
                }
                ## General Unicycler Options section
                opt+=" --mode '"+inputs.mode+"' "
                opt+=" --min_fasta_length '"+inputs.min_fasta_length+"' "
                opt+=" --linear_seqs '"+inputs.linear_seqs+"' "

                if (inputs.min_anchor_seg_len) != '' ){
                   opt+=" --min_anchor_seg_len '"+inputs.min_anchor_seg_len+"' "
                }
                ## Spades Options section
                opt+=" "+inputs.spades_no_correct
                opt+=" --min_kmer_frac '"+inputs.spades_min_kmer_frac+"' "
                opt+=" --max_kmer_frac '"+inputs.spades_max_kmer_frac+"' "
                if (inputs.spades_kmers) != ''){
                    opt+=" --kmers '"+inputs.spades_kmers+"' "
                }
                opt+=" --kmer_count '"+inputs.spades_kmer_count+"' "
                opt+=" --depth_filter '"+inputs.spades_depth_filter+"' "
                if (inputs.spades_largest_component){
                   opt+=" --largest_component "
                }
                ## Rotation Options section
                opt+=" "+inputs.rotation_no_rotate+" "
        
                if (inputs.rotation_start_genes){
                  opt+=" --start_genes '"+inputs.rotation_start_genes.path+"' +" "
                }
                opt+=" --start_gene_id '"+inputs.rotation_start_gene_id+"' "
                opt+=" --start_gene_cov '"+inputs.rotation_start_gene_cov+"' "

                ## Pilon Options section
                opt+=" "+inputs.pilon_no_pilon+" "
                if (inputs.pilon_min_polish_size  != ''){
                    opt+=" --min_polish_size '"+inputs.pilon_min_polish_size+"' "
                }
               
                ## Long Read Alignment Options
                if ( inputs.lr_align_contamination!=null){
                   opt+=" --contamination '"+inputs.lr_align_contamination+"' "
                }
                opt+=" --scores '"+inputs.lr_align_scores+"' "

                if (inputs.lr_align_low_score != ''){
                    opt+=" --low_score '"+inputs.lr_align_low_score+"' "
                }
               
                }
                
                ## Running Unicycler
                ${cmd_base} ${opt}
                
 
        writable: false
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'biocontainers/unicycler:v0.4.7dfsg-2-deb_cv1'
    
    
