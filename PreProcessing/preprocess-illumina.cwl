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
      - fastq_file_1
      - fastq_file_2
    run: ../bio-cwl-tools/sratoolkit/prefetch_fastq.cwl

  fastp:
    in:
      fastq1: fetch_fastqs/fastq_file_1
      fastq2: fetch_fastqs/fastq_file_2
    out:
      - out_fastq1
      - out_fastq2
      - html_report
      - json_report
    run: ../bio-cwl-tools/fastp/fastp.cwl

outputs:
  fastq_file_1:
    type: File
    outputSource: fetch_fastqs/fastq_file_1
  fastq_file_2:
    type: File?
    outputSource: fetch_fastqs/fastq_file_2

  fastp_fastq_1:
    type: File
    outputSource: fastp/out_fastq1
  fastp_fastq_2:
    type: File
    outputSource: fastp/out_fastq2
  fastp_html_report:
    type: File
    outputSource: fastp/html_report
  fastp_json_report:
    type: File
    outputSource: fastp/json_report