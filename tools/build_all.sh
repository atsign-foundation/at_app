#!/bin/bash

if [ ! -z "$GITHUB_ACTION" ];
then
  echo "ERROR: This script should only be run locally, do not use for github actions."
  exit 1
fi

# cd to project root
cd "$MELOS_ROOT_PATH" || exit 1

# Bundle everything without formatting or analysis
dart pub global run melos run bundle:bundler -- --no-format --no-analyze
dart pub global run melos run bundle:create -- --no-format --no-analyze
dart pub global run melos run bundle:templates -- --no-format --no-analyze

# Build at_app
dart pub global run melos run build:at_app

# Build the generated applications
dart pub global run melos run build:generated

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
dart analyze build/
