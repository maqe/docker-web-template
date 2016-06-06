#!/bin/sh

project="${PWD##*/}"
project=${project/-/}

eval "docker exec -it ${project}_web_1 $@"