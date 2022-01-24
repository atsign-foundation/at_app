#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_template"

cd "$BASE_PATH" || exit 1
dart run build_runner build --delete-conflicting-outputs
