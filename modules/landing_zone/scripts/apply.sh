#!/bin/bash

## Root path
if [ -z "${ROOT_PATH}" ]; then
  echo >&2 'ERROR: ROOT_PATH variable is empty. Aborting...'
  exit 1
fi

## Command
if [ -z "${COMMAND}" ]; then
  echo >&2 'ERROR: COMMAND variable is empty. Aborting...'
  exit 1
fi

## Components
if [ -z "${COMPONENTS}" ]; then
  echo >&2 'ERROR: COMMAND variable is empty. Aborting...'
  exit 1
fi

terrahub --version > /dev/null 2>&1 || { echo >&2 'terrahub is missing. Aborting...'; exit 1; }
python -V > /dev/null 2>&1 || { echo >&2 'python is missing. Aborting...'; exit 1; }

root="$ROOT_PATH" command="$COMMAND" components="$COMPONENTS" python ${ROOT_PATH}/modules/landing_zone/scripts/apply.py
