#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  illumina_accessions: string

steps:
  fetch_fastqs:
    in:
      sra_accession: illumina_accessions
    out:
      - fastq_files
    run: ../bio-cwl-tools/sratoolkit/prefetch_fastq.cwl

outputs:
  fastq_files:
    type: File[]
    outputSource: fetch_fastqs/fastq_files
