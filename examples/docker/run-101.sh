#!/bin/bash
linuxkit run hyperkit \
  -ip 192.168.65.101 \
  -disk $PWD/disk-101,size=4G \
  -state $PWD/docker-state-101 \
  docker

