## Assembly

### Unicycler tool

#### CWL

first working version :
```
cd  Assembly/tool/test
#test workflow
bash run_assembly_wf.sh  

#test tool
bash run_tool.sh  
```

#### Docker

```
pull last version

docker pull biocontainers/unicycler:v0.4.7dfsg-2-deb_cv1



alternative : local build (but depends of debian package update  here)

curl https://raw.githubusercontent.com/BioContainers/containers/master/unicycler/0.4.7dfsg-2-deb/Dockerfile > Dockerfile

docker build -t unicycler .


```










