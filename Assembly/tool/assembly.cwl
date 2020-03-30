class: Workflow
cwlVersion: v1.0
id: assembly
label: assembly
 
inputs:
  - id: sequence_long
    type: File
  
  - id: fastq_input2
    type: File
 
  - id: fastq_input1
    type: File
    
outputs:
  - id: assembly
    outputSource:
      - unicycler/assembly
    type: File
 
  - id: assembly_graph
    outputSource:
      - unicycler/assembly_graph
    type: File
 
steps:
  - id: unicycler
    in:
      - id: fastq_input1
        source: fastq_input1
      - id: fastq_input2
        source: fastq_input2
      - id: sequence_long
        source: sequence_long
    out:
      - id: assembly_graph
      - id: assembly
    run: ./unicycler.cwl
 
requirements: []
