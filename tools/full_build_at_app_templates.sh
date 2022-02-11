#!/bin/bash
TOOL_PATH="${BASH_SOURCE%/*}"

"$TOOL_PATH"/bundle_at_app_templates.sh
"$TOOL_PATH"/format_and_analyze.sh "at_app"
