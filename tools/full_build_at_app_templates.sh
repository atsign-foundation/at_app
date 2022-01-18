#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"
BASE_PATH="$TOOL_PATH/../at_app_templates"

"$TOOL_PATH"/bundle_at_app_templates.sh
"$TOOL_PATH"/format_and_analyze.sh "$BASE_PATH"
