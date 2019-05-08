#!/bin/bash



docker run --name mariadb -h mariadb --net=host  --restart=always \
	-v /data/var/lib/mysql:/var/lib/mysql\
	-v /data/etc/mysql:/etc/mysql/conf.d \
	-v /etc/localtime:/etc/localtime:ro \
	-e MYSQL_ROOT_PASSWORD=MysQLadminTmp123. \
	-d mariadb:5.5.61

exit 0
