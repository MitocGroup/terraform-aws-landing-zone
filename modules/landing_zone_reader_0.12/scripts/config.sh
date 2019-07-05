#!/bin/bash

## Root path
if [ -z "${ROOT_PATH}" ]; then
  echo >&2 'ERROR: ROOT_PATH variable is empty. aborting...'
  exit 1
fi

## Providers
if [ -z "${PROVIDERS}" ]; then
  echo >&2 'ERROR: PROVIDERS variable is empty. aborting...'
  exit 1
fi

## Components
if [ -z "${COMPONENTS}" ]; then
  echo >&2 'ERROR: COMPONENTS variable is empty. aborting...'
  exit 1
fi

terrahub --version > /dev/null 2>&1 || { echo >&2 'terrahub is missing. aborting...'; exit 1; }
python --version > /dev/null 2>&1 || { echo >&2 'python is missing. aborting...'; exit 1; }

python ${ROOT_PATH}/modules/landing_zone_reader_0.12/scripts/config.py
