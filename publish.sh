#!/bin/bash

# Loading config
source $(pwd)/config.build

if [ "$(ls -A $data_local/output)" ];
then
  echo "Copying files to OneDrive..."
  cp $data_local/output/* $data_local/onedrive/
else
  echo "Nothing to do..."
fi

