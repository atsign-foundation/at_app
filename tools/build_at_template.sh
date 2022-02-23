#!/bin/bash

AT_TEMPLATE_PATH="$MELOS_ROOT_PATH/packages/at_template"
BRICK_PATH="$AT_TEMPLATE_PATH/bricks"

CURRENT_DIR=$(pwd)

# ARGS
FORMAT=1

# ARG PARSER
while [ $# -gt 0 ];
do
  case "$1" in
    --no-format)
      FORMAT=0
    ;;
  esac
  shift
done

# Run build_runner build on json_serializable classes
cd "$AT_TEMPLATE_PATH" || exit 1
dart run build_runner build --delete-conflicting-outputs
cd "$CURRENT_DIR" || exit 1

# Build the mason bricks in at_template and output them into at_app
for BRICK in "$BRICK_PATH"/*;
do
  dart pub global run mason_cli:mason bundle -t dart -o "$AT_TEMPLATE_PATH/lib/src/bundles/$(basename "$BRICK")" "$BRICK";
done

# Format and analyze
if [ $FORMAT -gt 0 ] ;
then
  dart format -l 120 "$MELOS_ROOT_PATH/packages/at_template";
  dart analyze "$MELOS_ROOT_PATH/packages/at_template";
fi
