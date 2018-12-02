#!/bin/bash

PUID=$(id -u)
PGID=$(id -g)

docker run -ti --rm \
    -e PUID:${PUID} \
    -e PGID:${PGID} \
    -v `pwd`/library:/library \
    -v `pwd`/cache:/cache \
    -v `pwd`/root/optimiser:/optimiser:rw \
    -e LIBRARY_PATH=/library \
    -e DEBUGGING=false \
    -e SUPPORTED_CONTAINERS='avi,mkv' \
    josh5/libraryoptimiser:latest 

