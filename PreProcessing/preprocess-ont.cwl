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
      - fastq_files
    run: ../bio-cwl-tools/sratoolkit/prefetch_fastq.cwl

  nanoplot:
    in:
      fastq_files:
        source: fetch_fastqs/fastq_files
      loglength:
        valueFrom: $(true)
      format:
        valueFrom: "png"
    out:
      - dynamic_histogram_read_length
      - histogram_read_length
      - length_v_qual_scatter_plot_dot
      - length_v_qual_scatter_plot_kde
      - log_transformed_histogram_read_length
      - report
      - logfile
      - nanostats
      - weighted_histogram_read_length
      - weighted_log_transform_histogram_read_length
      - yield_by_length_img
    run: ../bio-cwl-tools/nanoplot/nanoplot.cwl

  fastqc:
    in:
      reads_file: fetch_fastqs/fastq_file_1
      nogroup:
        valueFrom: $(true)
      kmers:
        valueFrom: $(7)
    out:
      - zipped_file
      - summary_file
      - html_file
    run: ../bio-cwl-tools/fastqc/fastqc_2.cwl

  multiqc:
    in:
      qc_files_array: fastqc/zipped_file
    out:
      - multiqc_zip
      - multiqc_html
    run: ../bio-cwl-tools/multiqc/multiqc.cwl

  minimap2:
    in:
      indexFile: ref_human_genome
      fastqFiles: fetch_fastqs/fastq_file_1
      samOutput:
        valueFrom: $(true)
    out:
      - samfile
    run: ../bio-cwl-tools/minimap2/minimap2.cwl

  sam2bam:
    in:
      sam: minimap2/samfile
    out:
      - bam
    run: ../bio-cwl-tools/samtools/samtools_view_sam2bam.cwl

  samtools_fastq:
    in:
      bam_sorted: sam2bam/bam
    out:
      - fastq
    run: ../bio-cwl-tools/samtools/samtools_fastq.cwl
    
  rename_multiqc_html:
    in:
      srcfile: multiqc/multiqc_html
      newname:
        source: illumina_accession
        valueFrom: $(self)_multiqc.html
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

  rename_multiqc_zip:
    in:
      srcfile: multiqc/multiqc_zip
      newname:
        source: illumina_accession
        valueFrom: $(self)_multiqc.zip
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

  rename_fastqc_summary:
    in:
      srcfile: fastqc/summary_file
      newname:
        source: illumina_accession
        valueFrom: $(self)_fastqc.html
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

  rename_fastqc_zip:
    in:
      srcfile: fastqc/zipped_file
      newname:
        source: illumina_accession
        valueFrom: $(self)_fastqc.zip
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

  rename_fastq:
    in:
      srcfile: samtools_fastq/fastq
      newname:
        source: illumina_accession
        valueFrom: $(self).fastq
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

  rename_bam:
    in:
      srcfile: sam2bam/bam
      newname:
        source: illumina_accession
        valueFrom: $(self).bam
    out:
      - outfile
    run: ../bio-cwl-tools/util/rename.cwl

outputs:
  original_fastq1:
    type: File
    outputSource: rename_fastq/outfile

  fastqc_summary:
    type: File
    outputSource: rename_fastqc_summary/outfile
  fastqc_zip:
    type: File
    outputSource: rename_fastqc_zip/outfile


  multiqc_html:
    type: File
    outputSource: rename_multiqc_html/outfile
  multiqc_zip:
    type: File
    outputSource: rename_multiqc_zip/outfile

  bam:
    type: File
    outputSource: rename_bam/outfile