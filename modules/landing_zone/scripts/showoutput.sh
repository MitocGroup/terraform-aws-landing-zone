#!/bin/bash

## Source path
OUTPUT_FILE_PATH=${1}
if [ -z "${OUTPUT_FILE_PATH}" ]; then
  echo >&2 'ERROR: OUTPUT_FILE_PATH variable is empty. aborting...'
  exit 1
fi

cat ${OUTPUT_FILE_PATH}
rm ${OUTPUT_FILE_PATH}
