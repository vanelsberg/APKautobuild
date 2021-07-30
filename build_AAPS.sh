#!/bin/bash

# Building from Linux

# Loading config
source $(pwd)/config.build

# Run container in interactive mode
docker run --rm -v $data_local:$data_mount -it $image $1
