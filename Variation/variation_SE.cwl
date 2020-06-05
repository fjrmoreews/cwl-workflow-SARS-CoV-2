class: Workflow
cwlVersion: v1.0
id: var
label: var

inputs:
  # read(s):
  - id: reads
    type: File[]
    format:
      - edam:format_1930 # FASTA
      - edam:format_1931 # FASTQ

  # reference genome:
  - id: reference_in
    type: File

  #### 1-  fastp options:
  - id: unqualified_phred_quality
    type: int?
  - id: threads
    type: int?
  - id: qualified_phred_quality
    type: int?
  - id: min_length_required
    type: int?
  - id: force_polyg_tail_trimming
    type: boolean?
  - id: disable_trim_poly_g
    type: boolean?
  - id: base_correction
    type: boolean?

#### bowtie2_build options:
  - id: bmax
    type: int?
  - id: bmaxdivn
    type: int?
  - id: bt2_index_base
    type: string?
  - id: c
    type: boolean?
  - id: dcv
    type: int?
  - id: f
    type: boolean?
  - id: ftabchars
    type: int?
  - id: justref
    type: boolean?
  - id: large_index
    type: boolean?
  - id: noauto
    type: boolean?
  - id: nodc
    type: boolean?
  - id: noref
    type: boolean?
  - id: offrate
    type: int?
  - id: packed
    type: boolean?
  - id: quiet
    type: boolean?
  - id: seed
    type: int?
  - id: threads_bowtie2
    type: int?
#### bowtie2_align options: (many others)
  - id: end_to_end_very_sensitive
    type: boolean?

#### picard__sort_sam options:
  - id: sort_order
    type:
      - 'null'
      - type: enum
        symbols:
          - queryname
          - coordinate
          - duplicate
  - id: validation_stringency
    type:
      - 'null'
      - type: enum
        symbols:
          - STRICT
          - LENIENT
          - SILENT
#### picard__mark_duplicates options:
  - id: alignments_are_sorted
    type: boolean
  - id: remove_duplicates
    type: boolean
  - id: validation_stringency_1
    type:
      - 'null'
      - type: enum
        symbols:
          - STRICT
          - LENIENT
          - SILENT
  - id: comment
    type: string[]?
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - type: enum
        symbols:
          - SUM_OF_BASE_QUALITIES
          - TOTAL_MAPPED_REFERENCE_LENGTH
          - RANDOM
  - id: read_name_regex
    type: string?
  - id: optical_duplicate_pixel_distance
    type: int?
  - id: barcode_tag
    type: string?
####lofreq_viterbi options:
  - id: keepflags
    type: boolean?
  - id: defqual
    type: int?
  - id: bq2_handling
    type:
      - 'null'
      - type: enum
        symbols:
          - keep
          - dynamic
          - fixed
        name: bq2_handling

#### lofreq_cal_variants options:
  - id: bed
    type: File?
  - id: bonferroni
    type: string?
  - id: call_indels
    type: boolean?
  - id: def_alt_bq
    type: int?
  - id: def_alt_jq
    type: int?
  - id: del_baq
    type: boolean?
  - id: enable_source_qual
    type: boolean?
  - id: ignore_vcf
    type: 'File[]?'
  - id: illumina_1_3
    type: boolean?
  - id: max_depth_cov
    type: int?
  - id: max_mapping_quality
    type: int?
  - id: min_bq
    type: int?
  - id: min_cov
    type: int?
  - id: min_mq
    type: int?
  - id: use_orphan
    type: boolean?
  - id: threads_lf_call
    type: int?
  - id: replace_non_match
    type: int?
  - id: region
    type: string?
  - id: pvalue_cutoff
    type: float?
  - id: only_indels
    type: boolean?
  - id: no_idaq
    type: boolean?
  - id: no_default_filter
    type: boolean?
  - id: no_baq
    type: boolean?
  - id: no_mapping_quality
    type: boolean?
  - id: no_ext_base_alignment_quality
    type: boolean?
  - id: min_jq
    type: int?
  - id: min_alt_jq
    type: int?
  - id: min_alt_bq
    type: int?

#### SnpEff buiild & ann:
  - id: genome_reference
    type: string
  - id: udLength
    type: int
  - id: transcripts
    type: File?
  - id: strict
    type: boolean?
  - id: spliceSiteSize
    type: int?
  - id: spliceRegionIntronMin
    type: int?
  - id: spliceRegionIntronMax
    type: int?
  - id: spliceRegionExonSize
    type: int?
  - id: sequenceOntology
    type: boolean?
  - id: outputFormat
    type:
      - 'null'
      - type: enum
        symbols:
          - vcf
          - bed
          - gatk
          - bedAnn
        name: outputFormat
  - id: onlyReg
    type: boolean?
  - id: onlyProtein
    type: boolean?
  - id: oicr
    type: boolean?
  - id: noStats
    type: boolean?
  - id: noShiftHgvs
    type: boolean?
  - id: noNextProt
    type: boolean?
  - id: noMotif
    type: boolean?
  - id: bankfile
    type: File?
  - id: cancer
    type: boolean?
  - id: cancerSamples
    type: File?
  - id: canon
    type: boolean?
  - id: classic
    type: boolean?
  - id: csvFile
    type: boolean?
  - id: filterInterval
    type: 'File[]?'
  - id: hgvs
    type: boolean?
  - id: formatEff
    type: boolean?
  - id: html_report_1
    type: boolean?
  - id: importGenome
    type: boolean
  - id: interval
    type: 'File[]?'
  - id: lof
    type: boolean?
  - id: motif
    type: boolean?
  - id: nextProt
    type: boolean?
  - id: no_downstream
    type: boolean?
  - id: no_EffectType
    type: boolean?
  - id: no_intergenic
    type: boolean?
  - id: no_intron
    type: boolean?
  - id: no_upstream
    type: boolean?
  - id: no_utr
    type: boolean?
  - id: noGenome
    type: boolean?
  - id: noHgvs
    type: boolean?
  - id: noLof
    type: boolean?
  - id: geneId
    type: boolean?

#### SNPSIFT
  - id: separator
    type: string?
  - id: empty_text
    type: string?
  - id: extractFields
    type: 'string[]?'

outputs:
#FASTP:
#  - id: html_report
#    outputSource:
#      - fastp/html_report
#    type: File[]
  - id: multiqc_fastp
    outputSource:
      - multiqc_fastp/multiqc_zip
#  - id: json_report
#    outputSource:
#      - fastp/json_report
#    type: File[]
#  - id: out_fastq1
#    outputSource:
#      - fastp/out_fastq1
#    type: File[]

#BOWTIE2_BUILD:
#  - id: indices
#    outputSource:
#      - bowtie2_build/indices
#    type: File

#BOWTIE2_ALIGN:
#  - id: output
#    outputSource:
#      - bowtie2_align/output
#    type: File[]
  - id: output_log
    outputSource:
      - bowtie2_align/output_log
    type: File[]
#picard_sortsam:
#  - id: outFile
#    outputSource:
#      - picard__sort_sam/sorted_alignments
#    type: File[]

#picard_markduplicates
  - id: metrics
    outputSource:
      - picard__mark_duplicates/metrics
    type: File[]
  - id: log
    outputSource:
      - picard__mark_duplicates/log
    type: File[]
  - id: alignments
    outputSource:
      - picard__mark_duplicates/alignments
    type: File[]

#lofreq_viterbi:
#  - id: realigned
#    outputSource:
#      - lofreq_viterbi/realigned
#    type: File[]
#samtools_sort
#  - id: bam_sorted
#    outputSource:
#      - samtools_sort/bam_sorted
#    type: File[]
#lofreq_call:
#  - id: vcf
#    outputSource:
#      - lofreq_call/vcf
#    type: File[]
#SNPEFF:
  - id: csvFile
    outputSource:
      - snpeff_build_ann/csvFile
    type: File[]?
  - id: genes
    outputSource:
      - snpeff_build_ann/genes
    type: File[]?
#  - id: snpeff_output
#    outputSource:
#      - snpeff_build_ann/snpeff_output
#    type: File[]?
  - id: statsFile
    outputSource:
      - snpeff_build_ann/statsFile
    type: File[]?
#SNPSIFT:
  - id: out
    outputSource:
      - snpsift_extract/out
    type: File[]

steps:
  - id: fastp
    scatter: fastq1
    in:
      - id: base_correction
        source: base_correction
      - id: disable_trim_poly_g
        source: disable_trim_poly_g
      - id: fastq1
        source: reads
      - id: force_polyg_tail_trimming
        source: force_polyg_tail_trimming
      - id: min_length_required
        source: min_length_required
      - id: qualified_phred_quality
        source: qualified_phred_quality
      - id: threads
        source: threads
      - id: unqualified_phred_quality
        source: unqualified_phred_quality
    out:
      - id: html_report
      - id: json_report
      - id: out_fastq1
    run: ./tools/fastp.cwl
    in:
      - id: report_name
        valueFrom: 'multiqc_fast'
      - id: qc_files_array
        source: fastp/json_report
    out:
      - id: multiqc_zip
    run: ./tools/multiqc.cwl

  - id: bowtie2_build
    in:
      - id: bmax
        source: bmax
      - id: bmaxdivn
        source: bmaxdivn
      - id: bt2_index_base
        source: bt2_index_base
      - id: c
        source: c
      - id: dcv
        source: dcv
      - id: f
        source: f
      - id: ftabchars
        source: ftabchars
      - id: justref
        source: justref
      - id: large_index
        source: large_index
      - id: noauto
        source: noauto
      - id: nodc
        source: nodc
      - id: noref
        source: noref
      - id: offrate
        source: offrate
      - id: packed
        source: packed
      - id: quiet
        source: quiet
      - id: reference_in
        source:
          - reference_in
      - id: seed
        source: seed
      - id: threads
        source: threads_bowtie2
    out:
      - id: indices
      - id: output_log
    run: ./tools/bowtie2_build.cwl

  - id: bowtie2_align
    scatter: filelist
    in:
      - id: filelist
        source: fastp/out_fastq1
      - id: indices_file
        source: bowtie2_build/indices
      - id: end_to_end_very_sensitive
        source: end_to_end_very_sensitive
    out:
      - id: output
      - id: output_log
    run: ./tools/bowtie2_align.cwl
  - id: picard__sort_sam
    scatter: alignments
    in:
      - id: alignments
        source: bowtie2_align/output
      - id: sort_order
        source: sort_order
      - id: validation_stringency
        source: validation_stringency
    out:
      - id: sorted_alignments
    run: ./tools/picard_SortSam.cwl

  - id: picard__mark_duplicates
    scatter: alignments
    in:
      - id: alignments_are_sorted
        source: alignments_are_sorted
      - id: alignments
        source: picard__sort_sam/sorted_alignments
      - id: barcode_tag
        source: barcode_tag
      - id: comment
        source:
          - comment
      - id: duplicate_scoring_strategy
        source: duplicate_scoring_strategy
      - id: optical_duplicate_pixel_distance
        source: optical_duplicate_pixel_distance
      - id: remove_duplicates
        source: remove_duplicates
      - id: validation_stringency
        source: validation_stringency_1
    out:
      - id: alignments
      - id: log
      - id: metrics
    run: ./tools/picard_MarkDuplicates.cwl

  - id: lofreq_viterbi
    scatter: reads
    in:
      - id: bq2_handling
        source: bq2_handling
      - id: defqual
        source: defqual
      - id: keepflags
        source: keepflags
      - id: reads
        source: picard__mark_duplicates/alignments
      - id: reference
        source: reference_in
    out:
      - id: realigned
    run: ./tools/lofreq_viterbi.cwl
  - id: samtools_sort
    scatter: bam_unsorted
    in:
      - id: bam_unsorted
        source: lofreq_viterbi/realigned
    out:
      - id: bam_sorted
    run: ./tools/samtools_sort.cwl

  - id: samtools_faidx
    in:
      - id: sequences
        source: reference_in
    out:
      - id: sequences_index
      - id: sequences_with_index
    run: ../bio-cwl-tools/samtools/samtools_faidx.cwl

  - id: samtool_index
    scatter: bam_sorted
    in:
      - id: bam_sorted
        source: samtools_sort/bam_sorted
    out:
      - id: bam_sorted_indexed
    run: ./tools/samtools_index.cwl


  - id: lofreq_call
    scatter: [reads_align, reads_index]
    scatterMethod: "dotproduct"
    in:
      - id: threads
        source: threads_lf_call
      - id: reference_index
        source: samtools_faidx/sequences_index
      - id: reference_fasta
        source: samtools_faidx/sequences_with_index
      - id: call_indels
        source: call_indels
      - id: only_indels
        source: only_indels
      - id: bed
        source: bed
      - id: region
        source: region
      - id: min_bq
        source: min_bq
      - id: min_alt_bq
        source: min_alt_bq
      - id: def_alt_bq
        source: def_alt_bq
      - id: min_jq
        source: min_jq
      - id: min_alt_jq
        source: min_alt_jq
      - id: def_alt_jq
        source: def_alt_jq
      - id: no_baq
        source: no_baq
      - id: no_idaq
        source: no_idaq
      - id: del_baq
        source: del_baq
      - id: no_ext_base_alignment_quality
        source: no_ext_base_alignment_quality
      - id: min_mq
        source: min_mq
      - id: max_mapping_quality
        source: max_mapping_quality
      - id: no_mapping_quality
        source: no_mapping_quality
      - id: enable_source_qual
        source: enable_source_qual
      - id: ignore_vcf
        source:
          - ignore_vcf
      - id: replace_non_match
        source: replace_non_match
      - id: pvalue_cutoff
        source: pvalue_cutoff
      - id: bonferroni
        source: bonferroni
      - id: min_cov
        source: min_cov
      - id: max_depth_cov
        source: max_depth_cov
      - id: illumina_1_3
        source: illumina_1_3
      - id: use_orphan
        source: use_orphan
      - id: no_default_filter
        source: no_default_filter
      - id: reads_align
        source: samtools_sort/bam_sorted
      - id: reads_index
        source: samtool_index/bam_sorted_indexed
    out:
      - id: vcf
    run: ./tools/lofreq_call.cwl
    label: LoFreq Call Variants

  - id: snpeff_build_ann
    scatter: sequence
    in: 
      - id: importGenome
        source: importGenome
      - id: genome_reference
        source: genome_reference
      - id: bankfile
        source: bankfile
      - id: sequence
        source: lofreq_call/vcf
      - id: outputFormat
        source: outputFormat
      - id: udLength
        source: udLength
      - id: html_report
        source: html_report_1
      - id: csvFile
        source: csvFile
      - id: noStats
        source: noStats
      - id: formatEff
        source: formatEff
      - id: classic
        source: classic
      - id: sequenceOntology
        source: sequenceOntology
      - id: hgvs
        source: hgvs
      - id: noShiftHgvs
        source: noShiftHgvs
      - id: noHgvs
        source: noHgvs
      - id: geneId
        source: geneId
      - id: lof
        source: lof
      - id: noLof
        source: noLof
      - id: cancer
        source: cancer
      - id: cancerSamples
        source: cancerSamples
      - id: oicr
        source: oicr
      - id: canon
        source: canon
      - id: motif
        source: motif
      - id: noMotif
        source: noMotif
      - id: noNextProt
        source: noNextProt
      - id: nextProt
        source: nextProt
      - id: noGenome
        source: noGenome
      - id: onlyProtein
        source: onlyProtein
      - id: transcripts
        source: transcripts
      - id: interval
        source:
          - interval
      - id: spliceRegionExonSize
        source: spliceRegionExonSize
      - id: spliceRegionIntronMax
        source: spliceRegionIntronMax
      - id: spliceRegionIntronMin
        source: spliceRegionIntronMin
      - id: spliceSiteSize
        source: spliceSiteSize
      - id: onlyReg
        source: onlyReg
      - id: strict
        source: strict
      - id: filterInterval
        source:
          - filterInterval
      - id: no_downstream
        source: no_downstream
      - id: no_intergenic
        source: no_intergenic
      - id: no_intron
        source: no_intron
      - id: no_upstream
        source: no_upstream
      - id: no_utr
        source: no_utr
      - id: no_EffectType
        source: no_EffectType
    out:
      - id: snpeff_output
      - id: statsFile
      - id: csvFile
      - id: genes
    run: ./tools/snpEff_build_ann.cwl

  - id: snpsift_extract
    scatter: input_vcf
    in:
      - id: input_vcf
        source: snpeff_build_ann/snpeff_output
      - id: extractFields
        source:
          - extractFields
      - id: separator
        source: separator
      - id: empty_text
        source: empty_text
    out:
      - id: out
    run: ./tools/snpSift_extract.cwl

requirements:
  ScatterFeatureRequirement: {}
$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
