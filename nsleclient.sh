#!/bin/bash

docker run --name nsleclient-nodo1 -v /etc/localtime:/etc/localtime:ro \
				 -v /etc/hostname:/etc/hostname:ro \
				 -v /data/etc/letsencrypt:/letsencrypt \
				 -e IP=10.1.99.6 -e PORT=874 \
				 --restart=always \
				 --net=host \
				 --entrypoint=/usr/bin/ns-start \
				 -d nsoporte/nsleclient



exit 0
