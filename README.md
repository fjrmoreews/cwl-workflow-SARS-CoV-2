# cwl-workflow-SARS-CoV-2 
CWL workflows related to virus genomics with focus on SARS-CoV-2.

Part of the [COVID-19 Biohackathon](https://github.com/virtual-biohackathons/covid-19-bh20)  - April 5-11 2020


### road map
First task : migrate to CWL standard building blocks from 

https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics


Current members are working on the following analysis steps : 

- **PreProcessing** [branch](https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/tree/preprocessing/PreProcessing)
- **Assembly** [branch](https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/tree/assembly/Assembly)
- **Variation** [branch](https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/tree/variation/Variation)
- ~~S-Protein~~
- ~~MRCA~~
- ~~Recombination Selection~~

- To pursue this effort, we are looking for volunteers especially on task MRCA,
'S protein' analysis and Recombination Selection (but any complementary tasks  could be included as well)

### Why

The initial idea is to convert  Galaxy workflows in CWL
for different reasons : 

1/ CWL  is command line oriented. 
2/ no gui needed, but possible.
3/ execution environment is easy to deploy 
( with docker...) on local PC,clusters or cloud).
4/ interoperability, reusability
5/ developer oriented (for tool creators AND workflow designers)
6/ design toolbox (see rabix-composer )
7) open source + community

In a second time, using these components, other workflow designers will be able to refine the initial workflows and, we hope,  create new ones to follow the state of the art on COVID19 research



### How to 


```
#copy this code repository 

git clone https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2.git

#tool module management
#first option (clean)
git submodule init
git submodule update
git submodule foreach "(git checkout release; git pull)&"
######second option
git clone https://github.com/fjrmoreews/bio-cwl-tools.git
cp -r bio-cwl-tools ./cwl-workflow-SARS-CoV-2/
```


# for branch selection
cd bio-cwl-tools
git pull origin release

##  Contribute

- Workflow & tool dev  welcome !  
Ask to join on the biohackathon slack workflow channel
or pull request


More on CWL at https://www.commonwl.org

-  You can contribute as well if:
  you can wrap a tool as a script (python bash...)
  and/or know containers (docker...)
  

------------------
### First development steps & tricks

1/ It is easier to create the tools first.

To create a CWL tool from a Galaxy tool, you can 
decipher the tool XML files (like https://github.com/galaxyproject/tools-iuc/blob/master/tools/unicycler/unicycler.xml )


2/ After, the different tools/building blocks can be merge as a workflow. That step is easy if you use the [rabix-composer] (http://docs.rabix.io/rabix-composer-installation) to help you.



### What to do if you are new in CWL :

In many cases, an intermediary wrapper script is useful  to manage the input parameters and call the analytical tool

- you can, for example, begin by creating a python script with argparse. 
It will wrap the analytical tool command line (with subprocess, https://docs.python.org/3/library/subprocess.html), and then use the argparse2cwl tool to generate a  cwl file
see http://anton-khodak.github.io/argparse2cwl-blog/2016/08/11/gentle-introduction.html 


- Another option is to create a bash script, but you will need to write the cwl from scratch.  

##  best practice

- Create a branch, checkout , push your code 
- when your workflow is almost done, refactor it: 

  in the cwl workflow file, all  cwl tools should be defined as external files and called as follow:
```
  mytool:
    run: ../bio-cwl-tools/mytool/mytool.cwl
```

see example :  https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/blob/preprocessing/PreProcessing/preprocess-illumina.cwl

and cwl style guide : https://github.com/common-workflow-library/bio-cwl-tools#styleguide

 - ask for merging to master, when it's clean enought.
  
  
Then,  we will  update the bio-cwl-tools repository (fork), that will be merge , on a regular basis,  to the reference 
cwl tool main repository: https://github.com/common-workflow-library/bio-cwl-tools.



<!-- -->


