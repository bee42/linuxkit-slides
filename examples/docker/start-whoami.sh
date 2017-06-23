#!/bin/bash

set -e -x

# create traefik-net network
DOCKER_HOST=tcp://192.168.65.101

: NETWORK=${NETWORK:=traefik-net}
if [ ! "$(docker network ls --filter name=$NETWORK -q)" ];then
  docker network create --driver=overlay --attachable $NETWORK
fi

: SERVICES_COUNT=${SERVICES_COUNT:=1}

if [ ! -z "$1" ] ; then
  SERVICES_COUNT=$1
fi

whoami=emilevauge/whoami

for i in $(seq $SERVICES_COUNT); do
  if [ ! "$(docker service ls --filter name=whoami${i} -q)" ];then
    docker service create \
      --name whoami${i} \
      --label traefik.port=80 \
      --label traefik.enable=true \
      --label traefik.backend.loadbalancer=drr \
      --network $NETWORK \
     $whoami
  fi
done
