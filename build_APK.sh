#!/bin/bash

# Building from Linux

# Loading config
source $(pwd)/config.build

# Run container in interactive mode
cmd="docker run $docker_runparam --rm --name AAPSbuilder -v $data_local:$data_mount -it $image $1"

echo $cmd
eval $cmd

# tee -i $data_local/build.log
