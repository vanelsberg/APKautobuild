#!/bin/bash

# Loading config
source $(pwd)/config.build
source $data_local/asbuilder.config

if [ "$(ls -A $data_local/output)" ];
then
  dstdir=$data_local/$publishdir/${BUILDENV}$(date '+%Y%m%d_%H%M')
  echo $dstdir

  if [[ ! -z "${GIT_MERGE_PRNUM}" ]];
  then
    prnumlabel="${GIT_MERGE_PRNUM//,/+}"
    dstdir=${dstdir}_PR${prnumlabel}
  fi

  if [[ ! -z "${GIT_BRANCH}" ]];
  then
    dstdir=${dstdir}_${GIT_BRANCH}
  fi

  if [[ ! -z "${GIT_COMMIT}" ]];
  then
    dstdir=${dstdir}#${GIT_COMMIT}
  fi

  # Hint: create a symbolic link to a onedrive directory:
  # $ ln -s /mnt/c/Users/...../OneDrive/Distrib/APKautobuild data/onedrive
  echo "Copying files to ${dstdir}"
  mkdir -p $dstdir
  cp $data_local/output/* $dstdir/.
else
  echo "No files to publish..."
fi

