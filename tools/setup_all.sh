#!/bin/bash

if [ ! -z "$GITHUB_ACTION" ];
then
  echo "ERROR: This script should only be run locally, do not use for github actions."
  exit 1
fi

dart pub global run melos run setup:mason;
