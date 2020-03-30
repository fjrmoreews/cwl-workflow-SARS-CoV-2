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
      - unmapped_reads_sam
      - unmapped_reads_bam
    run: ./preprocess-illumina.cwl
  samtools_merge:
    in:
      output_name:
        valueFrom: "merged.bam"
      bams: main/unmapped_reads_bam
    out:
      - bam_merged
    run: ../bio-cwl-tools/samtools/samtools_merge.cwl

outputs:
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

  unmapped_reads_sam:
    type: File[]
    outputSource: main/unmapped_reads_sam
  unmapped_reads_bam:
    type: File[]
    outputSource: main/unmapped_reads_bam

  merged_bam:
    type: File
    outputSource: samtools_merge/bam_merged