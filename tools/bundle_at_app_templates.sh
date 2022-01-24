#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_app_templates"
BRICK_PATH="$BASE_PATH/lib/src"
OUTPUT_PATH="$TOOL_PATH/../at_app"

for x in "$BRICK_PATH"/*;
do
  for y in "$x"/*;
  do
    dart pub global run mason_cli:mason bundle -t dart -o "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$y")" "$y";
  done
done
