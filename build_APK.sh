#!/bin/bash

# Building from Linux

# Loading config
source $(pwd)/config.build

# Run container in interactive mode
# Optionally run with "--maxmemory=4g"

docker run $docker_runparam --rm --name AAPSbuilder -v $data_local:$data_mount -it $image $1
