#!/bin/bash

if [ -n "$GITHUB_ACTION" ];
then
  MELOS_ROOT_PATH="$GITHUB_WORKSPACE"
fi

BUNDLER_PATH="$MELOS_ROOT_PATH/packages/at_app_bundler"
BRICK_PATH="$BUNDLER_PATH/bricks"

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

# Build the mason bricks in at_app_create and output them into at_app
for BRICK in "$BRICK_PATH"/*;
do
  dart pub global run mason_cli:mason bundle -t dart -o "$BUNDLER_PATH/lib/src/bundles/$(basename "$BRICK")" "$BRICK";
done

# Format and analyze
if [ $FORMAT -gt 0 ];
then
  # Cannot format at_app_bundler directory directly
  # it will non-zero exit due to the dart templates in the bricks directory
  dart format -l 120 "$MELOS_ROOT_PATH/packages/at_app_bundler/lib";
  dart format -l 120 "$MELOS_ROOT_PATH/packages/at_app_bundler/bin";
fi

if [ $ANALYZE -gt 0 ];
then
  dart analyze "$MELOS_ROOT_PATH/packages/at_app_bundler";
fi
