#!/bin/bash

# Building from Linux

# Loading config
source $(pwd)/config.build

# Parse optional first parameter
case "$1" in
  --help)
      echo "Use: '$0 --clean' to build from start"
      exit
      ;;
  --clean)
      # ignore first parameter from here
      shift
      # Remove local Docker build volumes
      echo -e "===> Clean for full rebuild..."
      docker volume rm volAAPSgit
      docker volume rm volAAPSgradle
      echo -e "===> Cleaned!\n"
      ;;
  *)
      echo -e "\n===> Executing update build...\n"
      ;;
esac

mount_volAAPSgradle="-v volAAPSgradle:/root/.gradle"
mount_volAAPSgit="-v volAAPSgit:/user/src/asbuilder/AndroidAPS"
mount_data="-v $data_local:$data_mount"

# Run container in interactive mode
cmd="docker run $docker_runparam --rm --name AAPSbuilder ${mount_volAAPSgradle} ${mount_volAAPSgit} ${mount_data} -it $image $1"

echo $cmd
eval $cmd

# tee -i $data_local/build.log
