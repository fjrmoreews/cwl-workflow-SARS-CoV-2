#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  illumina_accessions: string[]
  ref_human_genome: File

steps:
  main:
    scatter: illumina_accession
    in:
      illumina_accession: illumina_accessions
      ref_human_genome: ref_human_genome
    out:
      - fastqc_summary
      - fastqc_zip
      - multiqc_html
      - multiqc_zip
      - original_fastq1
      - bam
    run: ./preprocess-ont.cwl

  merge_bam:
    in:
      output_name:
        valueFrom: "merged.bam"
      bams: main/bam
    out:
      - bam_merged
    run: ../bio-cwl-tools/samtools/samtools_merge.cwl

  samtools_fastq:
    in:
      bam_sorted: merge_bam/bam_merged
    out:
      - fastq
    run: ../bio-cwl-tools/samtools/samtools_fastq.cwl


outputs:
  original_fastq1:
    type: File[]
    outputSource: main/original_fastq1

  processed_fastq:
    type: File
    outputSource: samtools_fastq/fastq

  fastqc_summary:
    type: File[]
    outputSource: main/fastqc_summary
  fastqc_zip:
    type: File[]
    outputSource: main/fastqc_zip

  multiqc_htmls:
    type: File[]
    outputSource: main/multiqc_html
  multiqc_zips:
    type: File[]
    outputSource: main/multiqc_zip

$namespaces:
  edam: http://edamontology.org/

$schemas:
  - http://edamontology.org/EDAM_1.20.owl