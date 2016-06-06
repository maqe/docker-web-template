#!/bin/sh

project="${PWD##*/}"
project=${project/-/}

eval "docker run --rm --volumes-from ${project}_data_1 aimakun/nodejs-bower-grunt $@"