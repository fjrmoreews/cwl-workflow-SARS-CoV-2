class: Workflow
cwlVersion: v1.0
id: spaces_assembly
label: spaces_assembly



inputs:

##############


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

  - id: out_contigs
    outputSource:
      - spades/out_contigs
    type: 'File'

  - id: out_scaffolds
    outputSource:
      - spades/out_scaffolds
    type: 'File'

  - id: out_contig_stats
    outputSource:
      - spades/out_contig_stats
    type: 'File'


  - id: out_scaffold_stats
    outputSource:
      - spades/out_scaffold_stats
    type: 'File'


  - id: assembly_graph
    outputSource:
      - spades/assembly_graph
    type: 'File'

  - id: assembly_graph_with_scaffolds
    outputSource:
      - spades/assembly_graph_with_scaffolds
    type: 'File'

  - id: all_log
    outputSource:
      - spades/all_log
    type: 'File[]'

  - id: all_script
    outputSource:
      - spades/all_script
    type: 'File[]'





steps:
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

    out:

      - id: out_contigs
      - id: out_scaffolds

      - id: out_contig_stats
      - id: out_scaffold_stats

      - id: assembly_graph
      - id: assembly_graph_with_scaffolds

      - id: all_log
      - id: all_script



    run: ../../bio-cwl-tools/spades/spades.cwl

requirements: []

doc: |
       assemby workflow with  SPADES assembler

    

