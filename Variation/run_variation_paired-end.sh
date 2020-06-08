cd Variation/data
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/download/SRR10903401_forward.fastqsanger.gz 
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/download/SRR10903401_reverse.fastqsanger.gz
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/download/SRR10903402forward.fastqsanger
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/download/SRR10903402reverse.fastqsanger
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/downloadSRR10971381_forward.fastqsanger.gz
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/downloadSRR10971381_reverse.fastqsanger.gz
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/downloadSRR11059940_forward.fastqsanger.gz
wget https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/releases/latest/downloadSRR11059940_reverse.fastqsanger.gz
cd ..
cwl-runner variation_PE.cwl job-variation_PE.yml
