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
      - fastq
    run: ./preprocess-illumina.cwl

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

  fastqs:
    type: File[]
    outputSource: main/fastq