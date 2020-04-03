class: Workflow
cwlVersion: v1.0
id: variation
label: variation

inputs:
  - id: reference_in
    type:
      - File
      - type: array
        items: File
  - id: fastq1
    type: File[]
    
  - id: disable_trim_poly_g
    type: boolean?

  - id: force_polyg_tail_trimming
    type: boolean?

  - id: min_length_required
    type: int?

outputs: []
  # - id: multiqc_html
  #   outputSource:
  #     - multiqc/multiqc_html
  #   type: File
  
  # - id: sam
  #   outputSource:
  #     - bowtie2/sam
  #   type: File
steps:
  - id: bowtie2_build
    in:
      - id: reference_in
        source:
          - reference_in
    out:
      - id: indices
      - id: output_log
    run: ../bio-cwl-tools/bowtie2/bowtie2_build.cwl
 
  - id: fastp
    scatter: fastq1
    in:
      - id: disable_trim_poly_g
        source: disable_trim_poly_g
      - id: fastq1
        source: fastq1
      - id: force_polyg_tail_trimming
        source: force_polyg_tail_trimming
      - id: min_length_required
        source: min_length_required
    out:
      - id: html_report
      - id: json_report
      - id: out_fastq1
     # - id: out_fastq2
    run: ../bio-cwl-tools/fastp/fastp.cwl

  # - id: multiqc
    # in:
    #   - id: qc_files_array
    #     source:
    #       - fastp/html_report
    # out:
    #   - id: diree
    #   - id: multiqc_html
    #   - id: multiqc_zip
    # run: ./multiqc.cwl
    
#  - id: bowtie2
#    scatter: fastq1
#    in:
#      - id: fastq1
#        source: fastp/out_fastq1
#      - id: reference_index
#        source: bowtie2_build/indices
#    out:
#      - id: bowtie2_log
#      - id: sam
#    run: ./bowtie2.cwl
requirements: 
  - class: ScatterFeatureRequirement

