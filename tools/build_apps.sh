#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_app"
OUTPUT_PATH="$TOOL_PATH/../build"

MAIN_FILE="$BASE_PATH/bin/at_app.dart"

build_apps() {
  TYPE=$1
  shift
  LIST=("$@")
  for x in "${LIST[@]}"
  do
    NAME=$(tr -d '[:space:]' <<< "$x")

    echo "BUILDING $NAME"
    dart run "$MAIN_FILE" create "-$TYPE" "$NAME" --overwrite --project-name "${NAME}_test_app" "$OUTPUT_PATH/$NAME"
  done;
}

echo "CLEANING build/"
rm -rf "${OUTPUT_PATH:?}/"*

echo "READING TEMPLATES"
readarray -t TEMPLATES <<< "$(dart run "$MAIN_FILE" create --list-templates | cut -f1 -d '|' | sed -e '1,3d')"
echo "BUILDING TEMPLATES"
build_apps t "${TEMPLATES[@]}"

echo "READING SAMPLES"
readarray -t SAMPLES <<< "$(dart run "$MAIN_FILE" create --list-samples | cut -f1 -d '|' | sed -e '1,3d')"
echo "BUILDING SAMPLES"
build_apps s "${SAMPLES[@]}"

echo "READING DEMOS"
readarray -t DEMOS <<< "$(dart run "$MAIN_FILE" create --list-demos | cut -f1 -d '|' | sed -e '1,3d')"
echo "BUILDING DEMOS"
build_apps d "${DEMOS[@]}"
