#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/.."

dart format -l 120 "$BASE_PATH/$1";
dart analyze "$BASE_PATH/$1";
