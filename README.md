# IBM APP CONNECT ENTERPRISE for Microclimate

![ACE Logo](https://raw.githubusercontent.com/ot4i/ace-helm/master/appconnect_enterprise_logo.svg?sanitize=true)

## Introduction

IBM® App Connect Enterprise is a market-leading lightweight enterprise integration engine that offers a fast, simple way for systems and applications to communicate with each other. As a result, it can help you achieve business value, reduce IT complexity and save money. IBM App Connect Enterprise supports a range of integration choices, skills and interfaces to optimize the value of existing technology investments.

This container builds a bar file based on the artifacts stored in the `ace-pi` folder, and automatically deploys it to the ACE Server at start up.

A Microclimate instance can be pointed at a clone of this repository, and will build a new container and deploy the helm chart automatically.

## Prerequisites

Can be deployed with or without Microclimate.

## Docker Image

### Building the  base image

The base image can be built using standard [Docker commands](https://docs.docker.com/userguide/dockerimages/) against the Dockerfile supplied here: https://github.com/ot4i/ace-docker

~~~
cd ace-docker-master/11.0.0.0/ace/ubuntu-1604/base
docker build -t ibmcom/ace:11.0.0.0 .
~~~

### Building the image with the automated bar file build and deployment

~~~
docker build -t ace-microclimate:latest  .
~~~

### Running the image

~~~
docker run --name myMicroclimateAce -e LICENSE=accept -P ace-microclimate:latest
~~~

### Push the image to the ICP docker registry

1. Tag  Docker image with the necessary registry name and namespace
```
$ docker tag ace-microclimate:latest mycluster.icp:8500/<kubernetes_namespace>/ace-microclimate:latest
```
2. Login to the ICP Docker registry
```
docker login mycluster.icp:8500
```
3. Push the image
```
$ docker push mycluster.icp:8500/<kubernetes_namespace>/ace-microclimate:latest
```

## Create project and pipeline in Microclimate
1. Access Microclimate portal
2. Click on 'Import Project', and specify the github repository link (e.g. this repository) and access credentials
3. Select 'Unspecified' project type
4. In 'Overview', enable the project
5. Click on 'pipeline'
6. Create a new pipeline, using the same github repository
7. Add a deployment on the last successful build for the master branch
Note: at this point automated builds are not enabled for ACE projects in Microclimate

## Demonstration

Follow steps in https://github.com/ot4i/ace-microclimate/tree/master/demonstration

## Remove Helm Release
~~~
$ helm delete <helm release name> --tiller-namespace=<kubernetes_namespace> --purge
~~~
