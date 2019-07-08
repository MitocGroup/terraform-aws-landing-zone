#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

## Source path
OUTPUT_FILE_PATH=${1}
if [ -z "${OUTPUT_FILE_PATH}" ]; then
  echo >&2 'ERROR: OUTPUT_FILE_PATH variable is empty. aborting...'
  exit 1
fi

if [ -f ${OUTPUT_FILE_PATH} ]; then cat ${OUTPUT_FILE_PATH}; fi
if [ -f ${OUTPUT_FILE_PATH} ]; then rm ${OUTPUT_FILE_PATH}; fi
