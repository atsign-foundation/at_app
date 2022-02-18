#!/bin/bash
CURRENT_DIR=$(pwd)
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../packages/at_app"

cd "$BASE_PATH" || exit 1
dart run build_runner build
cd "$CURRENT_DIR" || exit 1
