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
  illumina_accession: string
  ref_human_genome: File

steps:
  fetch_fastqs:
    in:
      sra_accession: illumina_accession
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

  multiqc:
    in:
      qc_files_array: fastp/json_report
    out:
      - multiqc_zip
      - multiqc_html
    run: ../bio-cwl-tools/multiqc/multiqc.cwl

  bwa_mem:
    in:
      Index: ref_human_genome
      InputFile:
        source: [fastp/out_fastq1, fastp/out_fastq2]
        valueFrom: |
          ${
            return self.filter(function(x){return x});
          }
        linkMerge: merge_flattened
    out:
      - reads_stdout
    run: ../bio-cwl-tools/bwa/BWA-Mem.cwl

  samtools_view:
    in:
      sam: bwa_mem/reads_stdout
    out:
      - bam
    run: ../bio-cwl-tools/samtools/samtools_view_sam2bam.cwl

  rename_sam:
    in:
      srcfile: bwa_mem/reads_stdout
      newname:
        source: illumina_accession
        valueFrom: $(self).sam
    out:
      - outfile
    run: ./rename.cwl

  rename_bam:
    in:
      srcfile: samtools_view/bam
      newname:
        source: illumina_accession
        valueFrom: $(self).bam
    out:
      - outfile
    run: ./rename.cwl

  rename_multiqc_html:
    in:
      srcfile: multiqc/multiqc_html
      newname:
        source: illumina_accession
        valueFrom: $(self)_multiqc.html
    out:
      - outfile
    run: ./rename.cwl

  rename_multiqc_zip:
    in:
      srcfile: multiqc/multiqc_zip
      newname:
        source: illumina_accession
        valueFrom: $(self)_multiqc.zip
    out:
      - outfile
    run: ./rename.cwl

  rename_fastp_html:
    in:
      srcfile: fastp/html_report
      newname:
        source: illumina_accession
        valueFrom: $(self)_fastp.html
    out:
      - outfile
    run: ./rename.cwl

  rename_fastp_json:
    in:
      srcfile: fastp/json_report
      newname:
        source: illumina_accession
        valueFrom: $(self)_fastp.json
    out:
      - outfile
    run: ./rename.cwl

outputs:
  fastq_1:
    type: File
    outputSource: fetch_fastqs/fastq_file_1
  fastq_2:
    type: File?
    outputSource: fetch_fastqs/fastq_file_2

  fastp_1:
    type: File
    outputSource: fastp/out_fastq1
  fastp_2:
    type: File?
    outputSource: fastp/out_fastq2

  fastp_html_report:
    type: File
    outputSource: rename_fastp_html/outfile
  fastp_json_report:
    type: File
    outputSource: rename_fastp_json/outfile


  multiqc_html:
    type: File
    outputSource: rename_multiqc_html/outfile
  multiqc_zip:
    type: File
    outputSource: rename_multiqc_zip/outfile


  unmapped_reads_sam:
    type: File
    outputSource: rename_sam/outfile

  unmapped_reads_bam:
    type: File
    outputSource: rename_bam/outfile
