#!/bin/bash


#Run first
#docker run  -v /tmp:/tmp --entrypoint=/usr/bin/gen_conf -it nsoporte/fop2


docker run --name=fop2 --restart=always --net=host \
	-v /tmp:/tmp \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/hostname:/etc/hostname:ro \
	-v /data/etc/amportal.conf:/etc/amportal.conf:ro \
	-v /data/etc/issabelpbx.conf:/etc/issabelpbx.conf:ro \
	-v /data/etc/asterisk:/etc/asterisk:ro \
	-v /data/var/lib/asterisk:/var/lib/asterisk:ro \
	-v /data/var/lib/mysql:/var/lib/mysql \
	-v /data/etc/fop2/config.php:/var/www/html/fop2/admin/config.php:ro \
	-v /data/etc/fop2/fop2.cfg:/usr/local/fop2/fop2.cfg:ro \
	-v /opt/fop2/fop2.lic:/usr/local/fop2/fop2.lic \
	-d nsoporte/fop2

	
