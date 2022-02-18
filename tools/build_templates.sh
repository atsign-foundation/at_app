#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../templates"
BRICK_PATH="$BASE_PATH/lib"
OUTPUT_PATH="$TOOL_PATH/../packages/at_app"

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

# Bundle the templates from templates/ into at_app/
rm "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
touch "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
for x in "$BRICK_PATH"/*;
  do
  xbase=$(basename "$x")
  echo "export '$xbase/$xbase.dart';" >> "$OUTPUT_PATH/lib/src/bundles/bundles.dart"
  rm "$OUTPUT_PATH/lib/src/bundles/$xbase/$xbase.dart"
  touch "$OUTPUT_PATH/lib/src/bundles/$xbase/$xbase.dart"
  for y in "$x"/*;
  do
    ybase=$(basename "$y")
    echo "export '$ybase/$ybase.dart';" >> "$OUTPUT_PATH/lib/src/bundles/$(basename "$x")/$(basename "$x").dart"
    dart run "$TOOL_PATH/template_bundler/bin/main.dart" bundle -o "$OUTPUT_PATH/lib/src/bundles/$xbase/$ybase" "$y";
  done
done

# Format and analyze at_app
if [ $FORMAT -gt 0 ] ;
then
  "$TOOL_PATH"/format_and_analyze.sh "packages/at_app"
fi
