#!/bin/bash

if [ -n "$GITHUB_ACTION" ];
then
  echo "ERROR: This script should only be run locally, do not use for github actions."
  exit 1
fi

# cd to project root
cd "$MELOS_ROOT_PATH" || exit 1

# Bundle everything without formatting or analysis
./tools/build_at_app_bundler.sh --no-format --no-analyze
./tools/build_at_app_create.sh --no-format --no-analyze
./tools/bundle_templates.sh --no-format --no-analyze

# Build at_app
./tools/build_at_app.sh --no-format --no-analyze

# Format all generated code
dart format -l 120 packages/at_app_bundler/lib
dart format -l 120 packages/at_app_bundler/bin
dart format -l 120 packages/at_app_create/
dart format -l 120 packages/at_app/

# Analyze everything
dart analyze packages/at_app_flutter/
dart analyze packages/at_app_bundler/
dart analyze packages/at_app_create/
dart analyze packages/at_app/
