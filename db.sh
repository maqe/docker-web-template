#!/bin/sh

project="${PWD##*/}"
project=$(echo $project | sed -e "s/-//g")

dbname=$(docker exec ${project}_db_1 bash -c 'echo $MYSQL_DATABASE')
dbuser=$(docker exec ${project}_db_1 bash -c 'echo $MYSQL_USER')
dbpassword=$(docker exec ${project}_db_1 bash -c 'echo $MYSQL_PASSWORD')
dbport=$(docker port ${project}_db_1 | sed -e 's/[^:]*://g')

if [[ -z $dbuser ]]
	then
	dbuser="root"
fi

if [[ -z $dbpassword ]]
	then
	dbpassword=$(docker exec ${project}_db_1 bash -c 'echo $MYSQL_ROOT_PASSWORD')
fi

cp ./.docker/db-template.spf $TMPDIR/project.spf

sed -i "" -e "s/PROJECT/${PWD##*/}/g" \
	-e "s/DB_NAME/${dbname}/g" \
	-e "s/DB_USER/${dbuser}/g" \
	-e "s/DB_PASSWORD/${dbpassword}/g" \
	-e "s/DB_PORT/${dbport}/g" $TMPDIR/project.spf

open $TMPDIR/project.spf
