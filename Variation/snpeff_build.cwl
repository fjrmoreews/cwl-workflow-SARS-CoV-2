class: CommandLineTool
cwlVersion: v1.0

baseCommand: [snpEff, build]

arguments:
  - -v #verbose
  - -dataDir /data
  - -configOption $(inputs.dbname).genome=$(inputs.dbname)
inputs:
  - id: dbname
    type: string
    inputBinding:
      prefix: -genbank
      position: 1000

  - id: bankfile
    type: File
outputs:  []

requirements:
  - class: DockerRequirement
    dockerPull: biocontainers/snpeff:v4.1k_cv3
    dockerOutputDirectory: /data/
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: $(inputs.dbname)
        writable: true
      - entryname: $(inputs.dbname)/genes.gbk
        entry: $(inputs.bankfile)
