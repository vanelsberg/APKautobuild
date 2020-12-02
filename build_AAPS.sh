#!/bin/bash

# Building from Linux

# Mounting local data on container
data_mount=/data
data_local=$(pwd)/data

image=theod00r/aapsbuilder:0.1.1

# Run container in interactive mode
docker run --rm -v $data_local:$data_mount -it $image $1
