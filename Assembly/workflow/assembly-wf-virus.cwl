class: Workflow
cwlVersion: v1.0
id: assembly_wf_virus
label: assembly-wf-virus
 
doc:  "Virus genome assembly with Unicycler and spades, in parallel. visualisation with bandage"


inputs:

##############unicycler

  - id: fastq_file_type
    type:
      type: enum
      symbols: [paired,single]
    doc:  "Paired and single end data"
  
  
  - id: mode
    type:
      type: enum
      symbols: [conservative,normal,bold]
    doc: |
        Bridging mode, values:
        conservative (smaller contigs, lower misassembly)
        normal (moderate contig size and misassembly rate)
        bold  (longest contigs, higher misassembly rate)


  - id: fastq1_type
    type:
      type: enum
      symbols:
        - fastqsanger
        - fastqsanger.gz
    doc: "Type of the First set of reads. Only when fastq_file_type = single  or  paired"  
    default: fastqsanger

  - id: fastq1
    type: File
    doc: "First set of reads with forward reads. Only when fastq_file_type = single or paired" 


  - id: fastq2_type
    type:
     - "null"
     -  type: enum
        symbols:
         - fastqsanger
         - fastqsanger.gz
    default: "null"
    doc: "Type of the Second set of reads. Only when fastq_file_type=paired"  

    
  - id: fastq2
    type: File?
    doc: "Second set of reads with reverse reads. Only when fastq_file_type=paired"  





##############spades


  - id: libraries_metadata
    type:
      type: array
      items:
          type: record
          fields:
             - name: lib_index
               type: int? 

             - name: orientation
               type: string?
  
             - name: lib_type
               type: string? 


    doc: |
        reads library metadata
        related to   libraries_fwd_rev and libraries_mono inputs
        lib_index(id) must match


  - id: libraries_fwd_rev
    type:
      type: array
      items:
          type: record
          fields:

             - name: lib_index
               type: int? 

             - name: fwd_reads
               type: File?

             - name: rev_reads
               type: File?
    doc: |
        reads file
        orientation must be a value in  ff, fr, rf
        K-mer choices can be chosen by SPAdes instead of being entered manually


  - id: libraries_mono
    type:
      type: array
      items:
          type: record
          fields:

             - name: lib_index
               type: int? 

             - name: file_type
               type: string?

             - name: reads
               type: File?
    doc: |
        reads file
        file_type value must be in : interleaved, merged, unpaired



  - id: pacbio_reads
    type:
      - "null"
      - type: array
        items: File

  - id: nanopore_reads
    type:
      - "null"
      - type: array
        items: File

  - id: sanger_reads
    type:
      - "null"
      - type: array
        items: File

  - id: trusted_contigs
    type:
      - "null"
      - type: array
        items: File

  - id: untrusted_contigs
    type:
      - "null"
      - type: array
        items: File
 


 

  - id: auto_kmer_choice
    type:  boolean
    default: true
    doc: |
        Automatically choose k-mer values.
        K-mer choices can be chosen by SPAdes instead of being entered manually

  - id: kmers
    type:  string
    default: "21,33,55"
    doc: |
        K-mers to use, separated by commas.
        Comma-separated list of k-mer sizes to be used 
        (all values must be odd, less than 128, listed in ascending order,
         and smaller than the read length). The default value is 21,33,55



  - id: cov_state
    type:
     - "null"
     -  type: enum
        symbols:
          - off
          - value
          - auto
    doc: |
        Coverage cutoff ( 'auto', or 'off', or 'value'). auto if null
        when cov_state=value (User Specific) , cov_cutoff must be provided


  - id: cov_cutoff
    type:  float?
    doc: |
        coverage cutoff value (a positive float number )

  - id: iontorrent
    type:  boolean
    default: false
    doc: |
        true if Libraries are IonTorrent reads.

  - id: sc
    type:  boolean
    default: false
    doc: |
        This option is required for MDA. 
        true if single-cell data. 

  - id: onlyassembler
    type: boolean
    default: false
    doc: |
        Run only assembly if true
        (without read error correction)


  - id: careful
    type: boolean
    default: true
    doc: |
        Careful correction.
        Tries to reduce number of mismatches and short indels. 
        Also runs MismatchCorrector, a post processing tool,
        which uses BWA tool (comes with SPAdes).

 




outputs:

  - id: out_contigs_spades
    outputSource:
      - spades/out_contigs
    type: 'File'

  - id: out_scaffolds_spades
    outputSource:
      - spades/out_scaffolds
    type: 'File'

  - id: out_contig_stats_spades
    outputSource:
      - spades/out_contig_stats
    type: 'File'


  - id: out_scaffold_stats_spades
    outputSource:
      - spades/out_scaffold_stats
    type: 'File'


  - id: assembly_graph_spades
    outputSource:
      - spades/assembly_graph
    type: 'File'

  - id: assembly_graph_with_scaffolds_spades
    outputSource:
      - spades/assembly_graph_with_scaffolds
    type: 'File'

  - id: all_log_spades
    outputSource:
      - spades/all_log
    type: 'File[]'

#  - id: all_script
#    outputSource:
#      - spades/all_script
#    type: 'File[]'

  - id: assembly_image_spades
    outputSource:
      - bandage_image_spades/image


    type: File

  - id: assembly_info_spades
    outputSource:
      - bandage_info_spades/assembly_graph_info
    type: File


  - id: assembly_graph_unicycler
    outputSource:
      - unicycler/assembly_graph
    type: File
 
  - id: assembly_unicycler
    outputSource:
      - unicycler/assembly
    type: File
 

#  - id: exec_script2
#    outputSource:
#      - unicycler/exec_script
#    type: File


  - id: assembly_image_unicycler
    outputSource:
      - bandage_image_unicycler/image
    type: File

  - id: assembly_info_unicycler
    outputSource:
      - bandage_info_unicycler/assembly_graph_info
    type: File










steps:

  - id: unicycler
    in:
      - id: fastq1_type
        source: fastq1_type
      - id: fastq1
        source: fastq1
      - id: fastq2_type
        source: fastq2_type
      - id: fastq2
        source: fastq2
      - id: mode
        source: mode
      - id: fastq_file_type
        source: fastq_file_type


    out:
#      - id: exec_script
      - id: assembly_graph
      - id: assembly
 
#    run: ../../bio-cwl-tools/unicycler/unicycler.cwl
    run: ./tool/unicycler.cwl 


  - id: spades
    in:

      - id: nanopore_reads
        source: nanopore_reads
      - id: pacbio_reads
        source: pacbio_reads
      - id: sanger_reads
        source: sanger_reads
      - id: libraries_metadata
        source: libraries_metadata
      - id: libraries_fwd_rev
        source: libraries_fwd_rev
      - id: libraries_mono
        source: libraries_mono
      - id: trusted_contigs
        source: trusted_contigs
      - id: untrusted_contigs
        source: untrusted_contigs
      - id: cov_state
        source: cov_state
      - id: cov_cutoff
        source: cov_cutoff
      - id: iontorrent
        source: iontorrent
      - id: sc
        source: sc
      - id: onlyassembler
        source: onlyassembler
      - id: careful
        source: careful

      - id: auto_kmer_choice
        source: auto_kmer_choice

      - id: kmers
        source: kmers
 
    out:

      - id: out_contigs
      - id: out_scaffolds

      - id: out_contig_stats
      - id: out_scaffold_stats

      - id: assembly_graph
      - id: assembly_graph_with_scaffolds

      - id: all_log
#      - id: all_script

#    run: ../../bio-cwl-tools/spades/spades.cwl
    run: ./tool/spades.cwl 
 
  - id: bandage_image_unicycler
    in:
      - id: graph
        source: unicycler/assembly_graph
    out:
      - id: image
#    run: ../../bio-cwl-tools/bandage/bandage-image.cwl
    run: ./tool/bandage-image.cwl
 
  - id: bandage_info_unicycler
    in:
      - id: graph
        source: unicycler/assembly_graph
    out:
      - id: assembly_graph_info
#    run: ../../bio-cwl-tools/bandage/bandage-info.cwl
    run: ./tool/bandage-info.cwl 
  - id: bandage_image_spades
    in:
      - id: graph
        source: spades/assembly_graph
    out:
      - id: image
#    run: ../../bio-cwl-tools/bandage/bandage-image.cwl
    run: ./tool/bandage-image.cwl 
  - id: bandage_info_spades
    in:
      - id: graph
        source: spades/assembly_graph
    out:
      - id: assembly_graph_info
#    run: ../../bio-cwl-tools/bandage/bandage-info.cwl
    run: ./tool/bandage-info.cwl


    
requirements: []



