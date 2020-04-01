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
      - fastp_html_report
      - fastp_json_report
      - multiqc_html
      - multiqc_zip
      - original_fastq1
      - original_fastq2
      - bam
    run: ./preprocess-illumina.cwl

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
  original_fastq2:
    type: File[]?
    outputSource: main/original_fastq2

  processed_fastq:
    type: File
    outputSource: samtools_fastq/fastq

  fastp_html_reports:
    type: File[]
    outputSource: main/fastp_html_report
  fastp_json_reports:
    type: File[]
    outputSource: main/fastp_json_report

  multiqc_htmls:
    type: File[]
    outputSource: main/multiqc_html
  multiqc_zips:
    type: File[]
    outputSource: main/multiqc_zip
