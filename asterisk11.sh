#!/bin/bash


docker run --name=asterisk  --net=host --restart=always -v /data/etc/asterisk:/etc/asterisk \
		-v /tmp:/tmp \
		-v /data/var/lib/asterisk:/var/lib/asterisk \
		-v /data/var/spool/asterisk:/var/spool/asterisk \
		-v /data/var/lib/mysql:/var/lib/mysql \
		-v /data/var/run/asterisk:/var/run/asterisk \
		-v /data/var/log/asterisk:/var/log/asterisk \
		-v /data/etc/issabelpbx.conf:/etc/issabelpbx.conf \
		-v /etc/localtime:/etc/localtime:ro \
		-v /etc/hostname:/etc/hostname:ro \
		-e G729=xeon -it nsoporte/asterisk:11.25.3_u1

