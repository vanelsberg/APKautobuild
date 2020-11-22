#!/bin/bash

# Building from Linux

# Mounting local data on container
data_mount=/data
data_local=$(pwd)/data

# Run container in interactive mode
docker run --rm -v $data_local:$data_mount -it theod00r/tvedockerrepo:0.1.0 $1
