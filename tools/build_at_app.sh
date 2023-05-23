#!/bin/bash

if [ -n "$GITHUB_ACTION" ];
then
  exit 1
fi

# ARGS
FORMAT=1
ANALYZE=1
# ARG PARSER
while [ $# -gt 0 ];
do
  case "$1" in
    --no-format)
      FORMAT=0;;
    --no-analyze)
      ANALYZE=0;;
  esac
  shift
done

CURRENT_DIR=$(pwd)

cd "$MELOS_ROOT_PATH/packages/at_app" || exit 1
dart pub global run build_runner build --delete-conflicting-outputs

cd "$CURRENT_DIR" || exit 1

# Format and analyze
if [ $FORMAT -gt 0 ];
then
  dart format -l 120 "$MELOS_ROOT_PATH/packages/at_app";
fi

if [ $ANALYZE -gt 0 ];
then
  dart analyze "$MELOS_ROOT_PATH/packages/at_app";
fi
