class: CommandLineTool
cwlVersion: v1.0

hints:
  - class: DockerRequirement
    dockerPull: biocontainers/snpeff:v4.1k_cv3

#to do with arguments:
baseCommand: [snpEff, build, -v, -configOption, covid19.genome=covid19, -genbank, -dataDir,/var/spool/cwl/snpeff_output, covid19]
#-configOption, covid19.codonTable=Standard,
# [ls, -R, ./snpeff_output]
inputs: 
  # - id: bankname
  #   type: string
  #   default: genbank
  #   inputBinding:
  #     prefix: -
  #     separate: false
  - id: dbname
    type: string
  - id: bankfile
    type: File
outputs:  []
#  - id: fasta
#    type: File
#    outputBinding:
#      glob: "snpeff_out/*.fasta"

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: snpeff_output/$(inputs.dbname)
        writable: true
      - entryname: snpeff_output/$(inputs.dbname)/genes.gbk
        entry: $(inputs.bankfile)

 #     - entryname: /home/biodocker/bin/snpEff/snpeff_output/$(inputs.dbname)/genes.gbk
 #       entry: $(inputs.bankfile)
       # writable: true
 #     - entryname: snpeff_output/snpEff.conf
 #       entry: |-
 #           $(inputs.dbname).genome : $(inputs.dbname)
 #           $(inputs.dbname).codonTable : Standard 
         
