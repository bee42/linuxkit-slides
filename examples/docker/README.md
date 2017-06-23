# Start a software appliance with linuxkit

## Setup linuxkit at your mac

```
$ brew tap linuxkit/linuxkit
$ brew install --HEAD moby
$ brew install --HEAD linuxkit
```

## Create os images with liunxkit

```
# create the docker.yml
# copy from example dir and add some lines to use /etc/daemon.xml with tcp access
#    binds:
#     - /etc/docker/daemon.json:/etc/docker/daemon.json
#     - /var/lib/docker:/var/lib/docker
#     - /lib/modules:/lib/modules
#files:
#  - path: /etc/docker/daemon.json
#    contents: '{"debug": true, "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}'
#
$ moby build --output kernel+initrd docker.yml
```

## Run your first docker machine

```
$ linuxkit run hyperkit \
  -ip 192.168.65.101 \
  -disk $PWD/disk-101,size=4G \
  -state $PWD/docker-state-101 \
  docker
$ runc exec -t docker /bin/sh
$ docker ps
$ curl http://127.0.0.1:2375/v1.28/info
```

second terminal access your docker for mac instance

```
$ docker run --rm -i docker
> export DOCKER_HOST=tcp://192.168.65.101:2375
> docker info
> docker run
```

install some images without registry

```
$ docker run -i -v /var/run/docker.sock:/var/run/docker.sock docker
$ docker save redis | docker -H tcp://192.168.65.101 load
```

__INFO__: At mac hyperkit the network is hostonly

## Linuxkit Swarm Mode support

* Start second machine
* create and join the swarm cluster

```
$ $ linuxkit run hyperkit \
  -ip 192.168.65.102 \
  -disk $PWD/disk-102,size=4G \
  -state $PWD/docker-state-102 \
  docker
# starts docker at separat terminal
$ docker run -ti docker
# option start access docker at your machine 101 or 102
# runc exec -t docker /bin/sh
> docker -H tcp://192.168.65.101 swarm init
> docker -H tcp://192.168.65.102 swarm join  \
  --token $(docker -H tcp://192.168.65.101 swarm join-token worker -q) \
  192.168.65.101:2377
> docker -H tcp://192.168.65.101 node ls
> docker -H tcp://192.168.65.101 \
  service create \
  --name whoami \
  --publish 8091:80 \
  --label traefik.port=80 \
  --label traefik.enable=true \
  --label traefik.backend.loadbalancer=drr \
    emilevauge/whoami
> curl 192.168.65.101:8091
> docker -H tcp://192.168.65.101 \
  service update --replicas=3 whoami
```

Very speedy setup of virtual machines. Think about this setup in context of your CI/CD setup. Start fresh instances in seconds for your deployment checks!

Regards
Peter (peter.rossbach@bee42.com)
