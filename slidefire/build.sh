#!/bin/bash
DECK=linuxkit-basics
TAG=containerdays-hamburg_2017-06
docker build -t="bee42/$DECK" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" bee42/$DECK)
docker tag $ID bee42/$DECK:$DATE
docker tag $ID bee42/$DECK:$TAG
#docker push bee42/$DECK
