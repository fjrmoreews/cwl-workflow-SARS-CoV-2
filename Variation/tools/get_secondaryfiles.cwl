class: CommandLineTool
cwlVersion: v1.0
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.sequence)
      - $(inputs.bwa_index)
baseCommand: [ls]
inputs:
  sequence:
    type: File
    secondaryFiles: .fai

  bwa_index:
    type: File
    secondaryFiles:
      - $(self.nameroot).ann 
      - $(self.nameroot).amb
      - $(self.nameroot).pac
      - $(self.nameroot).sa
    
outputs:
  sequences_with_index: 
    type: File
    secondaryFiles: 
      - $(inputs.bwa_index.nameroot).bwt
      - $(inputs.bwa_index.nameroot).sa
      - $(inputs.bwa_index.nameroot).pac
      - $(inputs.bwa_index.nameroot).ann
      - $(inputs.bwa_index.nameroot).amb
      - $(inputs.sequence.basename).fai
    outputBinding:
      glob: $(inputs.sequence.basename)

