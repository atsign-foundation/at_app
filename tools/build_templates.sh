#!/bin/bash

OUTPUT_PATH="$MELOS_ROOT_PATH/packages/at_app"
BRICK_PATH="$MELOS_ROOT_PATH/templates/lib"
TOOL_PATH="$MELOS_ROOT_PATH/tools"
BUNDLER_MAIN="$TOOL_PATH/template_bundler/bin/main.dart"

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
BUNDLE_FILE="$OUTPUT_PATH/lib/src/bundles/bundles.dart"

# Clear the bundle file
rm "$BUNDLE_FILE"
touch "$BUNDLE_FILE"

# Iterate over each type of templates
for TEMPLATE_TYPE in "$BRICK_PATH"/*;
  do

  # Get the basename for the template type
  TEMPLATE_TYPE_BASE=$(basename "$TEMPLATE_TYPE")
  echo "FOUND $TEMPLATE_TYPE_BASE"
  # Export the template type
  echo "export '$TEMPLATE_TYPE_BASE/$TEMPLATE_TYPE_BASE.dart';" >> "$BUNDLE_FILE"

  # Add the export file for each template in the template type
  TEMPLATE_TYPE_FILE="$OUTPUT_PATH/lib/src/bundles/$TEMPLATE_TYPE_BASE/$TEMPLATE_TYPE_BASE.dart"

  # Reset the export file
  rm "$TEMPLATE_TYPE_FILE"
  touch "$TEMPLATE_TYPE_FILE"

  for TEMPLATE_NAME in "$TEMPLATE_TYPE"/*;
  do
    # Get the basename, which is the exact template name
    TEMPLATE_NAME_BASE=$(basename "$TEMPLATE_NAME")

    # Add the export to the template type file
    echo "export '$TEMPLATE_NAME_BASE/$TEMPLATE_NAME_BASE.dart';" >> "$TEMPLATE_TYPE_FILE"

    # The template file for this template (dart code)
    TEMPLATE_NAME_FILE="$OUTPUT_PATH/lib/src/bundles/$TEMPLATE_TYPE_BASE/$TEMPLATE_NAME_BASE"
    echo "$TEMPLATE_NAME"
    echo "$TEMPLATE_NAME_FILE"
    # Run the bundler to generate the file
    dart run "$BUNDLER_MAIN" bundle -o "$TEMPLATE_NAME_FILE" "$TEMPLATE_NAME";
  done
done

# Format and analyze at_app
if [ $FORMAT -gt 0 ] ;
then
  dart format -l 120 "$MELOS_ROOT_PATH/packages/at_app";
  dart analyze "$MELOS_ROOT_PATH/packages/at_app";
fi
