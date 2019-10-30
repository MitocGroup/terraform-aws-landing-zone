#!/usr/bin/env bash

declare -a FOLDERS=("components")

S3_PATH="s3://terraform-aws-landing-zone/mycompany"
LOCAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd .. && pwd )"

for folder in "${FOLDERS[@]}"; do
  aws s3 sync --exclude "*" --include "*.tfvars" --include "*.tfimport" ${LOCAL_PATH}/${folder}/ ${S3_PATH}/${folder}/
done
