#!/bin/bash
linuxkit run hyperkit \
  -ip 192.168.65.102 \
  -disk $PWD/disk-102,size=4G \
  -state $PWD/docker-state-102 \
  docker

