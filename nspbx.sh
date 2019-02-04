#!/bin/bash


##########################################################
#                                                        #
# Escrito por Christopher Naranjo G. NSOPORTE            #
#            			cnarnajo@nsoporte.com    #
#            						 #
##########################################################

SERVICE="nspbx"
IMAGE="nsoporte/$SERVICE"

echo -n "Deteniendo $SERVICE......................."
docker stop $SERVICE
echo "Ok"
echo "Eliminando Contenedor ....................."
docker rm $SERVICE
echo "Ok"
echo "Eliminando Imagenes en cache.............."
docker rmi nsoporte/$SERVICE:latest
echo "Ok"

echo -n "Descargando Contenedor mas reciente.............."
docker pull $IMAGE
echo "Ok"

function check_files(){

	if [ ! -f $1 ];then
		echo "ERROR: el archivo $1 no se encuentra en el host"
		exit 1
	fi
}


#Comprobando archivos importantes
check_files "/etc/hostname"
check_files "/data/etc/amportal.conf"
check_files "/data/etc/issabelpbx.conf"
check_files "/data/etc/issabel.conf"


docker run --name=$SERVICE --net=host  --restart=always \
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
		-v /var/run/docker.sock:/var/run/docker.sock:rw \
		--privileged -d $IMAGE


exit 0
