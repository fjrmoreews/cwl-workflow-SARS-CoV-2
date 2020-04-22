### CWL virus assembly workflow

prototyped from a Galaxy workflow :

[https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics](https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics)

use the following tools, ported to CWL:



1. **UNICYCLER** assembler pipeline
   https://github.com/rrwick/Unicycler
   ​

2. **SPADES** genome assembler

   https://github.com/ablab/spades
   These 2 assemblers produce FASTA contig sequences
   and a  viewable assembly *graph* 
   ​
3.   **BANDAGE**, an assembly graph visualizer
   https://github.com/rrwick/Bandage




#### Installation

To run the workflow, you need to install **docker**, **python**  and **cwl-tool**

#### Test

On Linux, to test the workflow with a minimal non real dataset:

```

cd ./test 

#use the test script
bash run_assembly_wf.sh

#or use direcly cwl-runner
cwl-runner --outdir ./result ./assembly-wf-virus.cwl job-assembly.yml

ls  ./result
```

