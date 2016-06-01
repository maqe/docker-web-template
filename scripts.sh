#!/bin/sh

eval "docker run --rm --volumes-from ${PWD##*/}_data_1 aimakun/nodejs-bower-grunt $@"