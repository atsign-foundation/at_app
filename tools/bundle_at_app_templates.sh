#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../templates"
BRICK_PATH="$BASE_PATH/lib/src"
OUTPUT_PATH="$TOOL_PATH/../at_app"

rm "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
touch "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
for x in "$BRICK_PATH"/*;
do
  echo "export '$(basename "$x")/$(basename "$x").dart';" >> "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
  rm "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$x").dart"
  touch "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$x").dart"
  for y in "$x"/*;
  do
    echo "export '$(basename "$y")/$(basename "$y").dart';" >> "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$x").dart"
    dart run "$TOOL_PATH/template_bundler/bin/main.dart" bundle -o "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$y")" "$y";
  done
done
