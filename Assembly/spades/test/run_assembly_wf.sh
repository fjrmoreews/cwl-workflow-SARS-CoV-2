
cd ..
#OPT="--leave-tmpdir --leave-outputs --debug"
OPT=""

cwl-runner $OPT  ./spades_assembly_wf.cwl job-assembly.yml

