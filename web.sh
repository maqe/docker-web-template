#!/bin/sh

eval "docker exec -it ${PWD##*/}_web_1 $@"