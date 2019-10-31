#!/usr/bin/env bash

declare -a FOLDERS=("components")
S3_PATH="s3://terraform-aws-landing-zone"
LOCAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" >/dev/null 2>&1 && pwd )"

for i in "${FOLDERS[@]}"; do
  aws s3 sync --exclude "*" --include "*.tfvars" --include "*.tfimport" --include "*.xml" --content-type "text/plain" ${S3_PATH}/${i}/ ${LOCAL_PATH}/${i}/
done
