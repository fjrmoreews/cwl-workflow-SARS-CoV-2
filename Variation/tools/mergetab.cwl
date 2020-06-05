cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
baseCommand: [ls]
inputs:
  out_fastq1: File
  out_fastq2: File
outputs:
  tab:
    type: File[]
    outputBinding:
      outputEval: |
              ${var tab=[]
                tab.push(inputs.out_fastq1)
                tab.push(inputs.out_fastq2)
                return tab;
               } 
