#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
doc: decompression tool using Lempel-Ziv coding (LZ77)
requirements:
  DockerRequirement:
    dockerPull: alpine:3.9

baseCommand: [tar, xvzf]


inputs:
  file:
    type: File
    inputBinding: {}

outputs:
  hg_38_fa:
    type: File
    outputBinding:
      glob: static/hg38.fna
    secondaryFiles:
      - .fai
      - .fwt
      - .amb
      - .ann
      - .pac
      - .sa
      - .bwt
