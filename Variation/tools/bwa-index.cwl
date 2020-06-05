#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "quay.io/biocontainers/bwa:0.7.17--ha92aebf_3"
  InlineJavascriptRequirement: {}

inputs:
  InputFile:
    type: File
    format: edam:format_1929  # FASTA
    inputBinding:
      position: 200
    
  IndexName:
    type: string
    inputBinding:
      prefix: "-p"
      #valueFrom: $(self + ".bwt")
#Optional arguments
  algoType:
    type: 
      - "null"
      - type: enum
        symbols:
          - is
          - bwtsw
    inputBinding:
      prefix: "-a"

baseCommand: [bwa, index]

outputs: 
  index:
    type: File
    secondaryFiles: 
   #   - $(inputs.IndexName).bwt.bwt
      - $(inputs.IndexName).sa
      - $(inputs.IndexName).pac
      - $(inputs.IndexName).ann
      - $(inputs.IndexName).amb
    outputBinding:
      glob: $(inputs.IndexName).bwt
$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
