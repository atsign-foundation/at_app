#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_template"

"$TOOL_PATH"/build_at_template.sh
"$TOOL_PATH"/bundle_at_template.sh
"$TOOL_PATH"/format_and_analyze.sh "$BASE_PATH"
