#!/bin/bash

if [ "$GITHUB_ACTION" ];
then
  echo "ERROR: This script should only be run locally, do not use for github actions."
  exit 1
fi

# cd to project root
cd "$MELOS_ROOT_PATH" || exit 1

# First build the bundler
dart pub global run melos run build:bundler -- --no-format;

# Run the builds without format and analyze
dart pub global run melos run build:create -- --no-format;
dart pub global run melos run build:templates -- --no-format;

# Build at_app
dart pub global run melos run build:at_app;

# Build the demo applications
dart pub global run melos run build:generated;

# Format and analyze manually, so that the output appears at the end
dart format -l 120 packages/at_app_bundler/
dart format -l 120 packages/at_app_create/
dart format -l 120 packages/at_app/

dart analyze packages/at_app_flutter/
dart analyze packages/at_app_bundler/
dart analyze packages/at_app_create/
dart analyze packages/at_app/
dart analyze build/
