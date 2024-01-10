#!/bin/bash

# Building from Linux

# Loading config
source $(pwd)/config.build

# Parse optional first parameter
case "$1" in
  --help)
      echo "Use: '$0 [option]'  to build from start"
      echo "--clean    full rebuild"
      echo "--rebuild  Git code rebuild (reclone)"
      exit
      ;;
  --clean)
      # ignore first parameter from here
      shift
      # Remove local Docker build volumes
      echo -e "===> Clean for full rebuild..."
      docker volume rm volAAPSgit
      docker volume rm volAAPSgradle
      echo -e "===> Gradle & Git Cleaned!\n"
      ;;
  --rebuild)
      # ignore first parameter from here
      shift
      # Remove local Docker build volumes
      echo -e "===> Clean for Git rebuild..."
      docker volume rm volAAPSgit
      echo -e "===> Git cleaned!\n"
      ;;
  *)
      echo -e "\n===> Executing update build...\n"
      ;;
esac

# Run container in interactive mode
cmd="docker run $docker_runparam --rm --name AAPSbuilder \
--mount source=volAAPSgradle,target=/root/.gradle \
--mount source=volAAPSgit,target=/user/src/asbuilder/AndroidAPS \
--mount type=bind,source=$data_local,target=$data_mount \
-it $image $1"

echo $cmd
eval $cmd

# tee -i $data_local/build.log
