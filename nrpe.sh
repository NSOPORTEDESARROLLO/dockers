#!/bin/bash

docker run --name nrpe --net=host --privileged --restart=always \
	-v /etc/hostname:/etc/hostname:ro \
	-v /etc/localtime:/etc/localtime:ro \
	-v /proc:/host/proc \
	-v /:/host/disk/rootfs \
	-v /data:/host/disk/datafs \
	-v /tmp:/tmp \
	-v /data/etc/nrpe/custom:/custom \
	-v /data/etc/nrpe/plugins:/plugins \
	-v /var/run/utmp:/var/run/utmp:ro \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-d nsoporte/nrpe


exit 0
