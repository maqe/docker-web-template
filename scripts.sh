#!/bin/sh

project="${PWD##*/}"
project=$(echo $project | sed -e "s/-//g")

eval "docker run --rm --volumes-from ${project}_data_1 aimakun/nodejs-bower-grunt $@"