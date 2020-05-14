
cd ..
#OPT="--leave-tmpdir --leave-outputs --debug"
OPT=""

cwl-runner --outdir ./result $OPT  ./assembly-wf-virus.cwl job-assembly.yml

