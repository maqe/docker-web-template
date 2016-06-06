#!/bin/sh

project="${PWD##*/}"
project=$(echo $project | sed -e "s/-//g")

eval "docker exec -it ${project}_web_1 $@"