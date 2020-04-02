# cwl-workflow-SARS-CoV-2
CWL workflows related to virus genomics with focus on SARS-CoV-2


### road map
first task : migrate to CWL standard building blocks from 

https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics


Current members are working on the following analysis steps : 

- **PreProcessing**
- **Assembly**
- **Variation**
- ~~Protein~~



### how to 


```
#copy this code repository 

git clone https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2.git

git submodule init

git submodule update



```

##  contribute

- Workflow & tool dev welcome !  
Ask to join on the biohackathon slack workflow channel
or pull request

more on CWL at https://www.commonwl.org

-  You can contribute as well if:
  you can wrap a tool as a script (python bash...)
  and/or know containers (docker...)

##  best practice

- Create a branch, checkout , push your code 
- when your workflow is almost done, refactor it: 

  in the cwl workflow file, all  cwl tools should be defined as external files and called as follow:
```
  mytool:
    run: ../bio-cwl-tools/mytool/mytool.cwl
```

see example :  https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/blob/preprocessing/PreProcessing/preprocess-illumina.cwl

 - ask for merging to master, when it's clean enought.
  
  
Then,  we will  update the bio-cwl-tools repository (fork), that will be merge  to the original 
cwl tool main repository, on a regular basis.



<!-- -->


