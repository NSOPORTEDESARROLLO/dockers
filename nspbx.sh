#!/bin/bash


docker run --name=nspbx --net=host  --restart=always \
		-v /tmp:/tmp \
		-v /etc/hostname:/etc/hostname:ro \
		-v /data/var/www/db:/var/www/db \
		-v /data/var/log/httpd:/var/log/httpd \
		-v /data/var/run/asterisk:/var/run/asterisk \
		-v /data/etc/asterisk:/etc/asterisk \
		-v /data/var/spool/asterisk:/var/spool/asterisk \
		-v /data/var/lib/asterisk:/var/lib/asterisk \
		-v /data/etc/amportal.conf:/etc/amportal.conf:rw \
		-v /data/etc/issabelpbx.conf:/etc/issabelpbx.conf:rw \
		-v /data/etc/issabel.conf:/etc/issabel.conf:rw \
		-v /data/var/lib/mysql:/var/lib/mysql \
		-v /data/var/log/asterisk:/var/log/asterisk \
		-v /data/var/log/issabel:/var/log/issabel \
		-v /etc/localtime:/etc/localtime:rw \
		-v /data/etc/letsencrypt:/etc/letsencrypt \
		-v /data/etc/httpd/conf:/etc/httpd/conf \
		-v /data/etc/httpd/conf.d:/etc/httpd/conf.d \
		--privileged -d nsoporte/nspbx


exit 0
