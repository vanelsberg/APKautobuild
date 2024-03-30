#!/bin/bash

# Loading config
source $(pwd)/config.build

if [ "$(ls -A $data_local/output)" ];
then
  # Hint: create a symbolic link to a onedrive directory:
  # $ ln -s /mnt/c/Users/...../OneDrive/Distrib/APKautobuild data/onedrive
  echo "Copying files to $publishdir..."
  dstdir="$data_local/$publishdir/${BUILDENV}$(date '+%Y%m%d_%H%M')"
  mkdir -p $dstdir
  cp $data_local/output/* $dstdir/.
else
  echo "Nothing to do..."
fi

