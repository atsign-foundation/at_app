#!/bin/bash
CURRENT_DIR=$(pwd)
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../packages/at_template"
BRICK_PATH="$BASE_PATH/bricks"

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
cd "$BASE_PATH" || exit 1
dart run build_runner build --delete-conflicting-outputs
cd "$CURRENT_DIR" || exit 1

# Build the mason bricks in at_template
for x in "$BRICK_PATH"/*;
do
  dart pub global run mason_cli:mason bundle -t dart -o "$BASE_PATH/lib/src/bundles/$(basename "$x")" "$x" <<< n;
done

# Format and analyze
if [ $FORMAT -gt 0 ] ;
then
  echo 'CALLED FORMAT'
  "$TOOL_PATH"/format_and_analyze.sh 'packages/at_template'
fi
