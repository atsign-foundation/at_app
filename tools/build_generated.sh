#!/bin/bash

MAIN_FILE="$MELOS_ROOT_PATH/packages/at_app/bin/at_app.dart"
OUTPUT_PATH="$MELOS_ROOT_PATH/build"

build_apps() {
  for x in $2
  do
    NAME=$(echo "$x" | tr -d '[:space:]')

    echo "BUILDING $NAME"
    dart run "$MAIN_FILE" create "-$1" "$NAME" --overwrite --no-pub --project-name "${NAME}_test_app" "$OUTPUT_PATH/$NAME"
    echo -e "dependency_overrides:\n  at_app_flutter:\n    path: ../../packages/at_app_flutter" >> "$OUTPUT_PATH/$NAME/pubspec.yaml"
    dart pub get --directory="$OUTPUT_PATH/$NAME"
  done;
}

echo "CLEANING build/"
rm -rf "${OUTPUT_PATH:?}/"*

echo "READING TEMPLATES"
TEMPLATES="$(dart run "$MAIN_FILE" create --list-templates | cut -f1 -d '|' | sed -e '1,3d' | tr '\n' ' ')"
echo "BUILDING TEMPLATES"
echo "$TEMPLATES"
build_apps t "$TEMPLATES"

echo "READING SAMPLES"
SAMPLES="$(dart run "$MAIN_FILE" create --list-samples | cut -f1 -d '|' | sed -e '1,3d' | tr '\n' ' ')"
echo "BUILDING SAMPLES"
echo "$SAMPLES"
build_apps s "$SAMPLES"

echo "READING DEMOS"
DEMOS="$(dart run "$MAIN_FILE" create --list-demos | cut -f1 -d '|' | sed -e '1,3d' | tr '\n' ' ')"
echo "BUILDING DEMOS"
echo "$DEMOS"
build_apps d "$DEMOS"
