## Assembly

### Spades and Unicycler tools

#### CWL

working version :
```
#spades
cd  Assembly/spades/test
bash run_assembly_wf.sh

#unicycler
cd  Assembly/unicycler/test
#test workflow
bash run_assembly_wf.sh  

```

#### Docker

```
pull last version

docker pull biocontainers/unicycler:v0.4.7dfsg-2-deb_cv1



alternative : local build (but depends of debian package update  here)

curl https://raw.githubusercontent.com/BioContainers/containers/master/unicycler/0.4.7dfsg-2-deb/Dockerfile > Dockerfile

docker build -t unicycler .


```










