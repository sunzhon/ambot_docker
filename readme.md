# How to do

This repository provides some scripts to setup ambot environment in a docker container.


**If you have installed docker on your system. There are two ways to get docker images for the development container.**

## 1. pull image from dockerhub

docker image pull sunzhon/ambot_env:0.5
docker run -u root -it -v /dev/:/dev/ --privileged sunzhon/ambot_env:0.5 /bin/bash


## 2. build image using dockerfile. Run following command to generate a image of ambot development env

docker build --progress=plain -t sunzhon/ambot_env:0.51 --build-arg user=$USER -f ./Dockerfile --network host  .

[ docker run -u ${USER} -it -v /dev/:/dev/ --privileged sunzhon/ambot_env:0.51 /bin/bash ] && docker run -u suntao -it -v /dev/:/dev/ --privileged sunzhon/ambot_env:0.51 /bin/bash


**If you have not installed docker, you can run install.sh in this folder to install docker and run docker execution automatically. **
