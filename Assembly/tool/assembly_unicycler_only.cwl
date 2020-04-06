class: Workflow
cwlVersion: v1.0
id: assembly
label: assembly
doc:  "Paired data assembly with Unicycler,  non long reads in this version"

inputs:

  - id: fastq_file_type
    type:
      type: enum
      symbols: [paired,single]
    doc:  "Paired and single end data"
  
  
  - id: mode
    type:
      type: enum
      symbols: [conservative,normal,bold]
    doc: |
        Bridging mode, values:
        conservative (smaller contigs, lower misassembly)
        normal (moderate contig size and misassembly rate)
        bold  (longest contigs, higher misassembly rate)


  - id: fastq1_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
    doc: "Type of the First set of reads. Only when fastq_file_type = single  or  paired"  
    default: fastqsanger

  - id: fastq1
    type: File
    doc: "First set of reads with forward reads. Only when fastq_file_type = single or paired" 


  - id: fastq2_type
    type:
     - "null"
     -  type: enum
        symbols:
         - fastqsanger
         - fastqsanger.gz
    default: "null"
    doc: "Type of the Second set of reads. Only when fastq_file_type=paired"  

    
  - id: fastq2
    type: File?
    doc: "Second set of reads with reverse reads. Only when fastq_file_type=paired"  




 
outputs:
  - id: exec_script
    outputSource:
      - unicycler/exec_script
    type: File
 
  - id: assembly_graph
    outputSource:
      - unicycler/assembly_graph
    type: File
 
  - id: assembly
    outputSource:
      - unicycler/assembly
    type: File
 
steps:
  - id: unicycler
    in:
      - id: fastq1_type
        source: fastq1_type
      - id: fastq1
        source: fastq1
      - id: fastq2_type
        source: fastq2_type
      - id: fastq2
        source: fastq2
      - id: mode
        source: mode
      - id: fastq_file_type
        source: fastq_file_type


    out:
      - id: exec_script
      - id: assembly_graph
      - id: assembly
    run: ./unicycler.cwl
    
requirements: []




