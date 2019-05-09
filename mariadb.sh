#!/bin/bash

NAME="mariadb"
USER="root"
PWD="MysQLadminTmp123."
DATADIR="/data/var/lib/mysql"
CONFDIR="/data/etc/mysql"
BKPDIR="/opt/mariadb_bkp"
#SOCK="/var/lib/mysql/mysql.sock"    #NSPBX
SOCK="/var/run/mysqld/mysqld.sock" #Standard 
IMAGE="mariadb:5"


#Backup service:
#check if mariadb container
if [ ! -d $BKPDIR ];then 
	echo "Error: Please create a backup dir on $BKPDIR or configure new one"
	exit 1
fi

container=$(docker ps -a |grep -w $NAME)
if [ -d $DATADIR ];then 
	data=$(ls -A $DATADIR)
fi

if [ -d $CONFDIR ];then
	etc=$(ls -A $CONFDIR)
fi

function BackupData(){

	DIRNAME=$BKPDIR/$(date +%d-%m-%Y__%H-%M-%S)
	mkdir $DIRNAME
	
	if [ "$container" != "" ];then
		echo ""
		echo "A container image was found, Do you like include this image in the backup?"
		echo "                              yes/no                                      "
		read cont


		if [ "$cont" = "yes" ];then 

			containerfile=$DIRNAME/image.tar
			docker export $NAME > $containerfile
			
		else

			echo "Skipping image backup" 
		fi

	fi



	if [ "$data" !=  "" ];then 

		datafile=$DIRNAME/data.tar 
		cd $DATADIR
		tar -cvf $datafile *

	fi

	if [ "$etc" != "" ];then

		etcfile=$DIRNAME/etc.tar 
		cd $CONFDIR
		tar -cvf $etcfile *
	fi 



} 




if [ "$data" != "" ] || [ "$etc" != "" ];then
	echo "Do you want make a backup before upgrade?"
	echo "           yes/no                        "
	read ans     

	if [ "$ans" = "yes" ];then 
		BackupData

	fi	

fi





OldVersion=$(docker exec -it $NAME mysqld -V)


docker stop $NAME
docker rm $NAME
docker rmi $IMAGE



docker run --name $NAME --net=host  --restart=always \
	-v $DATADIR:/var/lib/mysql\
	-v $CONFDIR:/etc/mysql/conf.d \
	-v /etc/localtime:/etc/localtime:ro \
	-e MYSQL_ROOT_PASSWORD=$PWD \
	-d $IMAGE

if [ $? !=  0 ];then 

	echo "Error: No se pudo iniciar mariadb correctamante (docker run)"
	exit 1
fi



#Fixing MariaDB tables
sleep 5
docker exec -it $NAME mysql_upgrade --host=127.0.0.1 --user=$USER --password=$PWD --socket=$SOCK --force

if [ $? != 0 ];then
	echo "Error: al tratar de actualizar las tablas (mysql_upgrade)"
	exit 1
fi

NewVersion=$(docker exec -it $NAME mysqld -V)

echo ""
echo ""
echo "Old Mariadb Version $OldVersion"
echo "New Mariadb Version $NewVersion"
