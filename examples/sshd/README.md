# build sshd 

* create vm
* start vm
* build sshd client
* login via sshd


```
$ moby build --output kernel+initrd docker.yml
$ linuxkit run hyperkit \
  -ip 192.168.65.102 \
  sshd
$ docker build -t sshclient .
$ docker container run -it -v ~/.ssh:/root/.ssh sshclient
> ssh -i /root/.ssh/id_rsa root@192.168.65.102
```

Regards
Peter (peter.rossbach@bee42.com)
