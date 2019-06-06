#!/bin/bash

## Root path
if [ -z "${ROOT_PATH}" ]; then
  echo >&2 'ERROR: ROOT_PATH variable is empty. aborting...'
  exit 1
fi

## Command
if [ -z "${COMMAND}" ]; then
  echo >&2 'ERROR: COMMAND variable is empty. aborting...'
  exit 1
fi

## Components
if [ -z "${COMPONENTS}" ]; then
  echo >&2 'ERROR: COMPONENTS variable is empty. aborting...'
  exit 1
fi

## Region
if [ -z "${REGION}" ]; then
  echo >&2 'ERROR: REGION variable is empty. aborting...'
  exit 1
fi

## Account id
if [ -z "${ACCOUNT_ID}" ]; then
  echo >&2 'ERROR: ACCOUNT_ID variable is empty. aborting...'
  exit 1
fi

terrahub --version > /dev/null 2>&1 || { echo >&2 'terrahub is missing. aborting...'; exit 1; }
python --version > /dev/null 2>&1 || { echo >&2 'python is missing. aborting...'; exit 1; }

root="$ROOT_PATH" command="$COMMAND" components="$COMPONENTS" region="$REGION" account_id="$ACCOUNT_ID" python ${ROOT_PATH}/modules/landing_zone/scripts/apply.py
