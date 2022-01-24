#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_template"
BRICK_PATH="$BASE_PATH/bricks"

for x in "$BRICK_PATH"/*;
do
  dart pub global run mason_cli:mason bundle -t dart -o "$BASE_PATH/lib/src/bundles/$(basename "$x")" "$x";
done
