#!/bin/bash

docker run --name nsfirewall --net=host --privileged --restart=always \
	 -v /data/etc/shorewall:/etc/shorewall \
	 -v /etc/localtime:/etc/localtime:ro \
	 -d nsoporte/nsfirewall


exit 0
