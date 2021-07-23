#!/bin/bash

readonly PROXY=traefik

if [ ! "$(docker ps -q -f name=$PROXY)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$PROXY)" ]; then
        docker rm $PROXY
    fi

    cd ../traefik-proxy
    bash run.sh
    cd -
fi

bash vendor/bin/sail up -d
