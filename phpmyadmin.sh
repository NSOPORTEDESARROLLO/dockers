#!/bin/bash

docker run --name phpmyadmin  -p 8080:80 \
	-v /tmp:/tmp \
	-e PMA_HOST="172.17.0.1" \
	-e PMA_PORT=3306 \
	-d phpmyadmin/phpmyadmin


exit 0
