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

if [[ -z $(ls "/c/Program Files/" 2> /dev/null) ]]
    then
    cp ./.docker/db-template.spf $TMPDIR/project.spf

    sed -i "" -e "s/PROJECT/${PWD##*/}/g" \
        -e "s/DB_NAME/${dbname}/g" \
        -e "s/DB_USER/${dbuser}/g" \
        -e "s/DB_PASSWORD/${dbpassword}/g" \
        -e "s/DB_PORT/${dbport}/g" $TMPDIR/project.spf

    echo "Open DB connection with Sequel Pro.."
    open $TMPDIR/project.spf

else
    echo "Open DB connection with MySQL Workbench.."
    workbenchbin="/c/Program Files/MySQL/MySQL Workbench 6.3 CE/MySQLWorkbench.exe"
    eval "start \"\" \"${workbenchbin}\" -query ${dbuser}:{$dbpassword}@192.168.99.100:${dbport}"
fi