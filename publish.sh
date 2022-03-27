#!/bin/bash

# Loading config
source $(pwd)/config.build

if [ "$(ls -A $data_local/output)" ];
then
  # Hint: create a symbolic link to a onedrive directory:
  # $ ln -s /mnt/c/Users/...../OneDrive/Distrib/APKautobuild data/onedrive
  echo "Copying files to OneDrive..."
  dstdir="$data_local/onedrive/${BUILDENV}$(date '+%Y%m%d_%H%M')"
  mkdir $dstdir
  cp $data_local/output/* $dstdir/.
else
  echo "Nothing to do..."
fi

