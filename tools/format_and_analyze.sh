#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/.."

cd "$BASE_PATH" || exit 1

dart format -l 120 "$1";
dart analyze "$1";
