#!/bin/bash

docker run --name openvpn --restart=always --privileged  --net=host \
	-v /tmp:/tmp \
	-v /etc/localtime:/etc/localtime:ro \
	-v /data/etc/openvpn:/etc/openvpn \
	-v /data/var/log/openvpn:/var/log/openvpn \
	-v /etc/hostname:/etc/hostname:ro \
	-d nsoporte/openvpn


exit 0
